import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDEhxiclPqns08D4hY6cXPJCWjyL7_9rh0",
          appId: "1:1072942649857:web:95e0a1638c691af31c6600",
          messagingSenderId: "1072942649857",
          projectId: "eventsgbg-5654c"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
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
                    return MyHomePage();
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
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>{};

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

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
        page = FavouritePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
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

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favorites = appState.favorites.toList();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyMap(),
      ),
    );
  }
}

final List<Location> locations = [
  Location(
      id: '1',
      name: 'Place 1',
      type: 'Restaurant',
      latLng: LatLng(57.7089, 11.9746),
      rating: 4.5,
      icon: Icon(Icons.fastfood)),
  Location(
      id: '2',
      name: 'Place 2',
      type: 'Park',
      latLng: LatLng(57.7044, 11.9613),
      rating: 4.7,
      icon: Icon(Icons.nature)),
  Location(
      id: '3',
      name: 'Place 3',
      type: 'Museum',
      latLng: LatLng(57.6972, 11.9765),
      rating: 4.6,
      icon: Icon(Icons.museum)),
];

class MyMap extends StatelessWidget {
  static final LatLng gothenburg = LatLng(57.7089, 11.9746);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MarkerVisibility(),
      child: FlutterMap(
        options: MapOptions(
          center: gothenburg,
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}",
          ),
          MarkerLayerOptions(
            markers: locations
                .map((location) => Marker(
                      width: 80.0,
                      height: 80.0,
                      point: location.latLng,
                      builder: (ctx) => Consumer<MarkerVisibility>(
                        builder: (context, visibility, _) => GestureDetector(
                          onTap: () => visibility.visibleLocation == location
                              ? visibility.hideMarker()
                              : visibility.showMarker(location),
                          child: visibility.visibleLocation == location
                              ? Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      location.icon,
                                      SizedBox(width: 5),
                                      Expanded(
                                        // add this
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(location.name,
                                                softWrap: true,
                                                overflow: TextOverflow.visible),
                                            Text(location.type,
                                                softWrap: true,
                                                overflow: TextOverflow.visible),
                                            Text('${location.rating}⭐',
                                                softWrap: true,
                                                overflow: TextOverflow.visible),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : location.icon,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png
// https://upload.wikimedia.org/wikipedia/commons/7/75/GBG-logo_2021.png

class MarkerVisibility extends ChangeNotifier {
  Location? _visibleLocation;

  Location? get visibleLocation => _visibleLocation;

  void showMarker(Location location) {
    if (_visibleLocation != location) {
      _visibleLocation = location;
      notifyListeners();
    }
  }

  void hideMarker() {
    _visibleLocation = null;
    notifyListeners();
  }
}

class Location {
  final String id;
  final String name;
  final String type;
  final LatLng latLng;
  final double rating;
  final Icon icon;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.latLng,
    required this.rating,
    required this.icon,
  });
}
