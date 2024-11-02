import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/view/screens/home/home.dart';
import 'package:foodapp/view/screens/launch/auth/signin_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the stream is loading
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          return HomePage();
        } else {
          return SigninScreen(userEmail: 'tehreemrizwan30@gmail.com');
        }
      },
    );
  }
}
