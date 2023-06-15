import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/user_provider.dart';

class UserDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final User? user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body: (user == null)
          ? Center(child: Text('No user signed in.'))
          : ListView(
              children: <Widget>[
                ListTile(
                  title: Text('UID'),
                  subtitle: Text(user.uid),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(user.email ?? 'No email'),
                ),
                ListTile(
                  title: Text('Display Name'),
                  subtitle: Text(user.displayName ?? 'No display name'),
                ),
                ListTile(
                  title: Text('Phone Number'),
                  subtitle: Text(user.phoneNumber ?? 'No phone number'),
                ),
              ],
            ),
    );
  }
}
