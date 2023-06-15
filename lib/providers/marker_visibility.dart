import 'package:flutter/material.dart';
import 'package:namer_app/models/MockLocation.dart';

class MarkerVisibility extends ChangeNotifier {
  MockLocation? _visibleLocation;

  MockLocation? get visibleLocation => _visibleLocation;

  void showMarker(MockLocation location) {
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
