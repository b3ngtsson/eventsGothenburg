import 'dart:html';

import 'package:flutter/material.dart';
import '../models/MockLocation.dart';

class Favorites extends ChangeNotifier {
  List<MockLocation> _favoriteLocations = [];

  List<MockLocation> get favoriteLocations => _favoriteLocations;

  void add(MockLocation location) {
    _favoriteLocations.add(location);
    notifyListeners();
  }

  void remove(MockLocation location) {
    _favoriteLocations.remove(location);
    notifyListeners();
  }
}
