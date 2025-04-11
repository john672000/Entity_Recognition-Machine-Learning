import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uilearn/utilss/app_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:uilearn/utilss/buttons_texts.dart';
import 'dart:convert';

//Recording Audio

//Uploading the File
String? fp;
bool? _isUploaded;
Future<Map<String, String>> uploadFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, allowedExtensions: ['mp3', 'm4a', 'wav']);

  if (result == null) {
    _isUploaded = false;
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.dark,
          title: Text(
            "No File Selected",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.black,
            ),
          ),
          content: Text(
            "Please select a file to continue.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "OK",
                style: TextStyle(
                  color: AppTheme.black,
                ),
              ),
            ),
          ],
        );
      },
    );
    return {'FileName': 'File Upload Cancelled', 'FilePath': 'NULL'};
  } else {
    _isUploaded = true;
    String file = result.files.single.name;

    fp = result.files.single.path!;

    int fplen = result.files.single.path.toString().length;
    int flen = result.files.single.name.length;
    int lim = fplen - flen;
    String filepath = result.files.single.path.toString().substring(0, lim - 1);

    // ignore: unused_local_variable
    String formattedOutput = '''
 File Name: $file \n File Path: $filepath $_isUploaded 

  ''';

    return {'FileName': file, 'FilePath': filepath};
  }
}

//Sending the Uploaded File to the server
Future<Map<String, String>> processAudio(
    BuildContext context, File audio) async {
  Completer<Map<String, String>> completer = Completer<Map<String, String>>();

  final Uri transcribeUrl = Uri.parse('XXXXXXXXX');
  final Uri entityUrl = Uri.parse('XXXXXXXXX');

  var request = http.MultipartRequest('POST', transcribeUrl);
  request.files.add(await http.MultipartFile.fromPath('audio', fp!));

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppTheme.dark,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppTheme.accent1),
              ),
              SizedBox(height: 20),
              MainText(text: "Processing", txty: "Par", clr: true),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accent1,
                ),
                onPressed: () {
                  completer.complete({
                    "transcription": "REQUEST CANCELLED",
                    "entities": "REQUEST CANCELLED"
                  });
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop(); // Close the dialog
                  }
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: AppTheme.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  try {
    var responseFuture = request.send(); // Start request

    return await Future.any([
      completer.future,
      responseFuture.then((response) async {
        if (response.statusCode == 200) {
          String transcription = await response.stream.bytesToString();

          // Now send the transcribed text to extract_entities API
          var entityResponse = await http.post(
            entityUrl,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"text": transcription}),
          );

          if (entityResponse.statusCode == 200) {
            var entityData = jsonDecode(entityResponse.body);
            String extractedEntities = entityData["entities"].toString();

            return {
              "transcription": transcription,
              "entities": extractedEntities,
            };
          } else {
            throw Exception(
                "Entity Extraction Error: ${entityResponse.statusCode}");
          }
        } else if (response.statusCode == 400) {
          throw Exception("Bad Request: Check your file and try again.");
        } else if (response.statusCode == 500) {
          throw Exception("Server Error: Please try again later.");
        } else {
          throw Exception("Unexpected Error: ${response.statusCode}");
        }
      }),
    ]);
  } catch (e) {
    return {
      "transcription": "Error: ${e.toString()}",
      "entities": "Error: ${e.toString()}"
    }; // Catch and return errors
  } finally {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }
}
