import 'package:flutter/material.dart';
import 'package:uilearn/utilss/app_theme.dart';

showErrorDialog(BuildContext context, String message, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppTheme.dark,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.black,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.black,
            fontSize: 15,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
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
}

signInLogic(BuildContext context, String username, String password) {
  if (username.isEmpty || password.isEmpty) {
    showErrorDialog(
        context, "Please fill Username and Password.", "Required!!");
    return;
  }
  // if (username == "John" && password == "U") {
  //   Navigator.pushReplacementNamed(context, '/home', arguments: username);
  // }
  else {
    Navigator.pushReplacementNamed(context, '/home', arguments: username);
    // showErrorDialog(context, "Incorrect Username or Password.", "Ooppss!!");
  }
}
