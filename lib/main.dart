import 'package:flutter/material.dart';
import 'package:uilearn/pages/home_screen.dart';
import 'package:uilearn/pages/login_screen.dart';
import 'package:uilearn/pages/response_screen.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowMinSize(Size(1020, 829));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) {
          final String uname =
              ModalRoute.of(context)?.settings.arguments as String? ?? "Guest";
          return HomeScreen(uname: uname); // Pass uname to HomeScreen
        },
        '/response': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, String>?;

          return ResponseScreen(
            fn: args?['fileName'] ?? "Failed to fetch File Name",
            resp: args?['responseMessage'] ?? "Failed to fetch the Response",
            entities: args?['entities'] ?? "Failed to fetch Entities",
          );
        },
      },
    );
  }
}
