import 'package:flutter/material.dart';
import 'package:namer_app/screens/login/create_account.dart';
import 'package:namer_app/screens/login/password_reset.dart';
import 'package:namer_app/screens/login/sign_in_page.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.login), text: "Login"),
              Tab(icon: Icon(Icons.account_circle), text: "Create Account"),
              Tab(icon: Icon(Icons.lock_open), text: "Reset Password"),
            ],
          ),
          title: Text('Sign In'),
        ),
        body: TabBarView(
          children: [
            SigninScreen(),
            CreateAccountForm(),
            ResetAccountForm(),
          ],
        ),
      ),
    );
  }
}
