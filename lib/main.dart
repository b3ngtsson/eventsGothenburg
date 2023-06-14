import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/screens/error_page.dart';
import 'package:namer_app/screens/my_home_page.dart';
import 'package:provider/provider.dart';
import 'providers/marker_visibility.dart';
import 'providers/favorites.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDEhxiclPqns08D4hY6cXPJCWjyL7_9rh0",
          appId: "1:1072942649857:web:95e0a1638c691af31c6600",
          messagingSenderId: "1072942649857",
          projectId: "eventsgbg-5654c"));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Favorites()),
        ChangeNotifierProvider(create: (context) => MarkerVisibility()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp();

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event gbg',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: _initialization,
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return ErroPage();
                case ConnectionState.active:
                  return MyHomePage();
                case ConnectionState.waiting:
                  return MyHomePage();
                case ConnectionState.done:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  return MyHomePage();
                // You can reach your snapshot.data['url'] in here
              }
            },
          ),
        ),
      ),
    );
  }
}




// https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png
// https://upload.wikimedia.org/wikipedia/commons/7/75/GBG-logo_2021.png

