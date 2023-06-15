import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/screens/my_user_data.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'my_home_page.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  void _trySubmit() async {
    if (_formKey.currentState != null) {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();

      if (isValid) {
        _formKey.currentState?.save();
        UserCredential userCredential;

        try {
          print("email: " + _email.toString());
          print("password: " + _password.toString());
          userCredential = await _auth.signInWithEmailAndPassword(
              email: _email, password: _password);
          if (userCredential.user != null) {
            Provider.of<UserProvider>(context, listen: false)
                .setUser(userCredential.user!);
            print('Successfully signed in!');
            print('User ID: ${userCredential.user!.uid}'); // User ID
            print('User email: ${userCredential.user!.email}'); // User email
          } else {
            print('Failed to sign in.');
          }
        } on FirebaseAuthException catch (err) {
          print(err);
          if (err.code == 'user-not-found') {
            try {
              userCredential = await _auth.createUserWithEmailAndPassword(
                email: _email,
                password: _password,
              );
            } on FirebaseAuthException catch (err) {
              var message = 'An error occurred, please check your credentials!';

              if (err.message != null) {
                message = err.message!;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              key: ValueKey('email'),
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email address',
              ),
            ),
            TextFormField(
              key: ValueKey('password'),
              validator: (value) {
                if (value!.isEmpty || value.length < 7) {
                  return 'Password must be at least 7 characters long.';
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              child: Text('Login'),
              onPressed: _trySubmit,
            ),
          ],
        ),
      ),
    );
  }
}
