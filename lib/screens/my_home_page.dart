import 'package:flutter/material.dart';
import 'package:namer_app/screens/error_page.dart';

import '../widgets/generator_page.dart';
import 'login/loggedInOrLogin.dart';
import 'login/sign_in_orchestrator.dart';
import 'my_favorite_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  Widget page = GeneratorPage();

  bool extend = false;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        setState(() {
          extend = !extend;
        });
        page = GeneratorPage();
        break;
      case 1:
        page = GeneratorPage();
        break;
      case 2:
        page = FavoritesPage();
        break;
      case 3:
        page = LoggedInOrLogin();
        break;
      default:
        page = ErrorPage();
    }
    return LayoutBuilder(builder: (context, constaints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: extend && constaints.maxWidth > 500,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.menu),
                    label: Text(''),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.supervised_user_circle_outlined),
                    label: Text('user'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}
