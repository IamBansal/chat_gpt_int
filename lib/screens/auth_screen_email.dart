import 'package:chat_gpt_int/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreenEmail extends StatefulWidget {
  const AuthScreenEmail({super.key});

  @override
  _AuthScreenEmailState createState() => _AuthScreenEmailState();
}

class _AuthScreenEmailState extends State<AuthScreenEmail> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final User? user = userCredential.user;

      if (user != null) {
        // User signed in successfully
        print('User signed in: ${user.uid}');
        Navigator.push(context, MaterialPageRoute(builder:(context) => const HomePage()));
      }
    } catch (e) {
      // Error occurred during sign-in
      print('Sign-in error: $e');
    }
  }

  Future<void> _signUpWithEmailAndPassword() async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final User? user = userCredential.user;

      if (user != null) {
        // User signed up successfully
        Navigator.push(context, MaterialPageRoute(builder:(context) => const HomePage()));
        print('User signed up: ${user.uid}');
      }
    } catch (e) {
      // Error occurred during sign-up
      print('Sign-up error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pocket ChatGPT welcomes you!!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              obscuringCharacter: "*",
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: (){
                _signInWithEmailAndPassword;
              },
                child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: (){
                _signUpWithEmailAndPassword;
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
