// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:namer_app/screens/loading_screen.dart';
import 'package:namer_app/screens/login/sign_in_orchestrator.dart';
import 'package:namer_app/screens/my_user_data.dart';
import 'package:namer_app/screens/login/sign_in_page.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class LoggedInOrLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (ctx, userProvider, _) {
        if (userProvider == null) {
          print("UserProvider is null");
          return LoadingScreen(); // or some other widget that indicates an error
        } else if (userProvider.user == null) {
          // If the user is not signed in, show the SigninScreen
          return SignInPage();
        } else {
          // If the user is signed in, show the LoggedInUser
          return LoggedInUser();
        }
      },
    );
  }
}

class LoggedInUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserDataScreen();
  }
}
