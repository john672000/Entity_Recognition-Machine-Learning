import 'package:flutter/material.dart';
import 'package:uilearn/functions/fnsign_in.dart';
import 'package:uilearn/utilss/app_theme.dart';
import 'package:uilearn/utilss/buttons_texts.dart';
import 'package:uilearn/utilss/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String uname = "";
  bool isLoading = false; // Track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.accent1,
        title: MainText(
          text: "Application",
          txty: "Main",
          clr: true,
        ),
        centerTitle: true,
        actions: [
          ActionButton(
            icon: Icons.help_outline,
            onPressed: () {},
            clr: true,
          )
        ],
      ),
      backgroundColor: AppTheme.dark,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Column(children: [
                  MainText(
                    text: 'USERNAME',
                    txty: "Sub",
                    clr: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextfield(
                    maxLines: 1,
                    hintText: '@.com',
                    controller: usernameController,
                    ishidden: false,
                  ),
                  const SizedBox(height: 50),
                  MainText(
                    text: 'PASSWORD',
                    txty: "Sub",
                    clr: true,
                  ),
                  const SizedBox(height: 10),
                  CustomPasswordfield(
                    maxLines: 1,
                    hintText: '******',
                    controller: passwordController,
                  ),
                  const SizedBox(height: 10),
                  MainText(text: "Forgot Password", txty: "Par", clr: true),
                  const SizedBox(height: 40),
                  // Button that triggers loading state
                  isLoading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(AppTheme.accent1),
                        ) // Show loading spinner
                      : MainButton(
                          text: 'SIGN IN',
                          onPressed: () {
                            String username = usernameController.text;
                            String password = passwordController.text;
                            setState(() {
                              isLoading =
                                  true; // Start loading when button pressed
                            });
                            Future.delayed(Duration(seconds: 2), () {
                              signInLogic(context, username, password);
                              setState(() {
                                isLoading = false;
                                usernameController.text = "John Emmanuel";
                                passwordController.text = "U";
                              });
                            });
                          },
                        ),
                  const SizedBox(height: 50),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
