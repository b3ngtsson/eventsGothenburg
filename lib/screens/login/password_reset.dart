import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:namer_app/screens/my_user_data.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../my_home_page.dart';

class ResetAccountForm extends StatefulWidget {
  @override
  _ResetAccountFormState createState() => _ResetAccountFormState();
}

class _ResetAccountFormState extends State<ResetAccountForm> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late String _email;

  void _trySubmit() async {
    if (_formKey.currentState != null) {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();

      if (isValid) {
        _formKey.currentState?.save();
        try {
          await _auth.sendPasswordResetEmail(email: _email);
        } on FirebaseAuthException catch (err) {
          print(err);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password reset'),
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
            SizedBox(height: 12),
            ElevatedButton(
              child: Text('Reset password'),
              onPressed: _trySubmit,
            ),
          ],
        ),
      ),
    );
  }
}
