import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uilearn/functions/fnhome_page.dart';
import 'package:uilearn/pages/response_screen.dart';
import 'package:uilearn/utilss/app_theme.dart';
import 'package:uilearn/utilss/buttons_texts.dart';

class HomeScreen extends StatefulWidget {
  final String uname;
  const HomeScreen({super.key, required this.uname});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Use SchedulerBinding to show SnackBar after the current frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Center(
                child: Text('Successfully signed in as ${widget.uname}'))),
      );
    });
  }

  String? filePath;
  String? rpfn; //Recent Process File Name
  List<Map<String, String>> recentProcesses = []; //Recent Process List
  String message =
      "             Let's get Started!!! \n Choose one of your options below";
  String heading = "Console Output"; // Heading inside the container
  File?
      selectedFile; // Selected File to pass in the Field of the Process _Audio

  bool _isUploaded = false;
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            MainText(text: "Welcome ${widget.uname}", txty: "Main", clr: true),
        centerTitle: true,
        backgroundColor: AppTheme.accent1,
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: Scaffold.of(context).openDrawer,
              icon: Icon(
                Icons.menu,
                color: AppTheme.black,
              ));
        }),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            hoverColor: AppTheme.dark,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: AppTheme.dark,
                      title: MainText(text: "Confirm", txty: "Main", clr: true),
                      content: MainText(
                          text: "Are you sure?", txty: "Sub", clr: true),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login',
                                (route) => false,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Center(
                                        child: Text(
                                            'Successfully signed out ${widget.uname}'))),
                              );
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                color: AppTheme.black,
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: AppTheme.black,
                              ),
                            )),
                      ],
                    );
                  });
            },
          ),
        ], //Actions
      ),
      drawer: Drawer(
        width: 300,
        backgroundColor: AppTheme.dark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 350,
              height: 80,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: AppTheme.accent1,
                ),
                child: Center(
                    child: MainText(text: "History", txty: "Main", clr: true)),
              ),
            ),
            Expanded(
              child: recentProcesses.isNotEmpty
                  ? ListView.builder(
                      itemCount: recentProcesses.length,
                      itemBuilder: (context, index) {
                        final process = recentProcesses[index];
                        return ListTile(
                          title: MainText(
                              text: process['FileName'] ?? 'Unkown File',
                              txty: "Main",
                              clr: true),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResponseScreen(
                                  fn: process['FileName'] ?? "Unkwon File",
                                  resp: process['Transcription'] ??
                                      "Unfilled Transcription",
                                  entities: process['Entities'] ??
                                      "No Entities Found",
                                ),
                              ),
                            );
                            setState(() {});
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: AppTheme.accent1),
                            onPressed: () {
                              setState(() {
                                recentProcesses.removeAt(index);
                              });
                            },
                          ),
                        );
                      })
                  : Center(
                      child: Text(
                        "No Recent Activity",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      backgroundColor: AppTheme.dark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 600,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.black,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    color: AppTheme.dark,
                    child: MainText(
                        text: heading.toUpperCase(), txty: "Main", clr: true),
                  ),
                  SizedBox(height: 60),
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.dark,
                    ),
                    child: Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          message,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 20,
                            color: AppTheme.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 150),
                // MainButton(
                //   text: _isRecording ? "Stop Recording" : "Start Recording",
                //   onPressed: _isUploaded
                //       ? null
                //       : () {
                //           _isRecording = !_isRecording;
                //           if (_isRecording) {
                //             setState(() {
                //               message =
                //                   "Recodring Started, Click Stop to Stop Recording";
                //               heading = "Recording Status";
                //             });
                //           } else {
                //             setState(() {
                //               message = "Recording Stopped";
                //               _isRecording = false;
                //             });
                //           }
                //         },
                // ),
                SizedBox(width: 20),
                MainButton(
                  text: "Upload File",
                  onPressed: _isUploaded || _isRecording
                      ? null
                      : () async {
                          Map<String, String> fp = await uploadFile(context);
                          setState(() {
                            message = fp['FilePath']!;
                            selectedFile = File(fp['FilePath']!);
                            if (fp['FileName'] == 'File Upload Cancelled' ||
                                fp['FilePath'] == "NULL") {
                              setState(() {
                                heading = "ERROR STATUS";
                                message = fp['FileName']!;
                                _isUploaded = false;
                              });
                            } else {
                              rpfn = fp['FileName']!.toString();
                              heading = "Selected File Status";
                              message =
                                  "Name: ${fp['FileName']} \nPath: ${fp['FilePath']}";
                              _isUploaded = true;
                            }
                          });
                        },
                ),
                SizedBox(width: 20),
                MainButton(
                  text: "Start Processing",
                  onPressed: !_isUploaded || _isRecording
                      ? null
                      : () async {
                          if (selectedFile != null) {
                            Map<String, String> response =
                                await processAudio(context, selectedFile!);
                            String transcription = response["transcription"] ??
                                "No transcription available";
                            String entities =
                                response["entities"] ?? "No entities extracted";
                            setState(() {
                              if (rpfn != null && response.isNotEmpty) {
                                recentProcesses.add({
                                  'FileName': rpfn ?? "Untitled_Audio",
                                  'Transcription': transcription,
                                  'Entities': entities,
                                });
                              }
                            });

                            if (response['entities'] != "REQUEST CANCELLED" &&
                                response['transcription'] !=
                                    "REQUEST CANCELLED") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResponseScreen(
                                    fn: rpfn ?? "Unknown File",
                                    resp: transcription,
                                    entities: entities,
                                  ),
                                ),
                              ).then((_) {
                                setState(() {
                                  _isUploaded = false;
                                  heading = "Process Status";
                                  message =
                                      "Sucessfully Processed \nYou can also check your History on the left bar!!";
                                  Future.delayed(Duration(seconds: 3), () {
                                    setState(() {
                                      heading = "STATUS";
                                      message = "Choose another File";
                                    });
                                  });
                                });
                              });
                            }
                            if (response['entities'] == "REQUEST CANCELLED" &&
                                response['transcription'] ==
                                    "REQUEST CANCELLED") {
                              setState(() {
                                heading = "ERROR";
                                message = "Process Cancelled";
                                _isUploaded = false;
                                Future.delayed(Duration(seconds: 5), () {
                                  setState(() {
                                    heading = "STATUS";
                                    message = "Choose another File";
                                  });
                                });
                              });
                            }
                          }
                        },
                ),
                SizedBox(width: 20),
                _isUploaded == true
                    ? ActionButton(
                        icon: Icons.cancel_outlined,
                        onPressed: () async {
                          setState(() {
                            _isUploaded = false;
                            heading = "ALERT";
                            message = "Process Called Back!!!";
                            Future.delayed(Duration(seconds: 3), () {
                              setState(() {
                                heading = "STATUS";
                                message = "Let's Try again";
                              });
                            });
                          });
                        },
                        clr: true)
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
