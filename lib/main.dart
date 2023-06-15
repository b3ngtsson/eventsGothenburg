import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/providers/user_provider.dart';
import 'package:namer_app/screens/error_page.dart';
import 'package:namer_app/screens/loading_screen.dart';
import 'package:namer_app/screens/my_home_page.dart';
import 'package:namer_app/screens/loggedInOrLogin.dart';
import 'package:namer_app/screens/sign_in_page.dart';
import 'package:provider/provider.dart';
import 'providers/marker_visibility.dart';
import 'providers/favorites.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Favorites()),
        ChangeNotifierProvider(create: (context) => MarkerVisibility()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

Future<User?> initializeApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return FirebaseAuth.instance.currentUser;
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: initializeApp(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Event gbg',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            ),
            home:
                MyHomePage(), // you don't need the ternary operator here as you're returning the same widget
            routes: {
              '/signin': (context) => SigninScreen(),
              // You can define more named routes here
            },
            onUnknownRoute: (settings) =>
                MaterialPageRoute(builder: (context) => ErrorPage()),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: LoadingScreen(),
          );
        } else {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: ErrorPage(),
          );
        }
      },
    );
  }
}


// https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png
// https://upload.wikimedia.org/wikipedia/commons/7/75/GBG-logo_2021.png

