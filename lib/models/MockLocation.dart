import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class MockLocation {
  final String id;
  final String name;
  final String type;
  final LatLng latLng;
  final double rating;
  final Icon icon;

  MockLocation({
    required this.id,
    required this.name,
    required this.type,
    required this.latLng,
    required this.rating,
    required this.icon,
  });
}
