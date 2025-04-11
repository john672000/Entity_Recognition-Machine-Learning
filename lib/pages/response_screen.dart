import 'package:flutter/material.dart';
import 'package:uilearn/utilss/app_theme.dart';
import 'package:uilearn/utilss/buttons_texts.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
// ignore: unused_import
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart'; // Updated import for cross-platform
import 'dart:io';

class ResponseScreen extends StatefulWidget {
  final String resp;
  final String fn;
  final String entities;
  const ResponseScreen(
      {super.key,
      required this.resp,
      required this.fn,
      required this.entities});

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {
  TextEditingController resText = TextEditingController();
  TextEditingController traText = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 2. Set the custom text
    traText.text = widget.resp;
    resText.text = widget.entities;
  }

  Future<void> _generateAndDownloadPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              resText.text, // Add text from TextField
              style: pw.TextStyle(fontSize: 24),
            ),
          );
        },
      ),
    );

    // Get the directory to save the PDF (use application documents directory)
    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/${widget.fn}.pdf");

    // Save the PDF to the file
    await file.writeAsBytes(await pdf.save());

    // Show SnackBar with the saved file path
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 10),
          content: Center(child: Text("PDF saved to ${file.path}"))),
    );
  }

  void _copyText(TextEditingController controller, String name) {
    final text = controller.text;
    final fieldname = name;
    if (text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Center(
                child: Text('Text copied to clipboard! from $fieldname'))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.accent1,
        leading: BackButton(
          color: AppTheme.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:
            MainText(text: "Response : ${widget.fn}", txty: "Main", clr: true),
        centerTitle: true,
      ),
      backgroundColor: AppTheme.dark,
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: AppTheme.accent1,
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          MainText(text: "TRANSCRIPT", txty: "Main", clr: true),
                          const SizedBox(width: 30),
                          IconButton(
                              hoverColor: AppTheme.accent1,
                              onPressed: () => _copyText(traText, "TRANSCRIPT"),
                              icon: Icon(Icons.copy)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: traText,
                                textAlign: TextAlign.justify,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: AppTheme.black,
                                  fontSize: 20.0,
                                ),
                                maxLines: null,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: AppTheme.accent1,
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            MainText(
                                text: "FORMATTED", txty: "Main", clr: true),
                            const SizedBox(width: 30),
                            IconButton(
                                onPressed: () =>
                                    _copyText(resText, "FORMATTED"),
                                hoverColor: AppTheme.accent1,
                                icon: Icon(Icons.copy)),
                            IconButton(
                                onPressed: _generateAndDownloadPDF,
                                hoverColor: AppTheme.accent1,
                                icon: Icon(Icons.sim_card_download_outlined))
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  controller: resText,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    color: AppTheme.black,
                                    fontSize: 20.0,
                                  ),
                                  maxLines: null,
                                )),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
