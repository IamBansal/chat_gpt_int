import 'package:chat_gpt_int/screens/auth_screen.dart';
import 'package:chat_gpt_int/screens/auth_screen_email.dart';
import 'package:chat_gpt_int/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'API Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // home: AuthScreen(),
//       // home: const HomePage(),
//       home: const AuthScreenEmail(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreenEmail(),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
