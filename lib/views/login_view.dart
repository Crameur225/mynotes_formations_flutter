import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'),
      elevation: 28,),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter your email here for login',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Enter your password here for login',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
      
              try {
                final userCredential = FirebaseAuth.instance
                    .signInWithEmailAndPassword(email: email, password: password);
                print(userCredential);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print("Error: No user found for that email.");
                } else if (e.code == 'wrong-password') {
                  print("Error: Wrong password provided for that user.");
                } else if (e.code == 'invalid-email') {
                  print("Error: The email address is not valid.");
                } else if (e.code == 'user-disabled') {
                  print("Error: This user account has been disabled.");
                } else {
                  print("An unknown Firebase error occurred: ${e.message}");
                }
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/register/', (_) => false);
            },
            child: Text("Not registered yet? Register here!"),
          ),
        ],
      ),
    );
  }
}
