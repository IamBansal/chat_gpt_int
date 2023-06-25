import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isSigningIn = false;
  //
  // Future<void> _signInWithGoogle() async {
  //   setState(() {
  //     _isSigningIn = true;
  //   });
  //
  //   final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //
  //   if (googleUser != null) {
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     try {
  //       final UserCredential userCredential = await _auth.signInWithCredential(credential);
  //       final User? user = userCredential.user;
  //
  //       if (user != null) {
  //         // User signed in successfully
  //         print('User signed in: ${user.displayName}');
  //       }
  //     } catch (e) {
  //       // Error occurred during sign-in
  //       print('Sign-in error: $e');
  //     }
  //   }
  //
  //   setState(() {
  //     _isSigningIn = false;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: Center(
        child: _isSigningIn
            ? const CircularProgressIndicator()
            : ElevatedButton(
          onPressed: () {
            // _signInWithGoogle();
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }


}
