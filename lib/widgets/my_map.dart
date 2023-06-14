import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../models/MockLocation.dart';
import '../providers/favorites.dart';
import '../providers/marker_visibility.dart';

class MyMap extends StatelessWidget {
  static final LatLng gothenburg = LatLng(57.7089, 11.9746);

  @override
  Widget build(BuildContext context) {
    Favorites favorites = Provider.of<Favorites>(context);

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
            markers: mockLocationList
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(location.name),
                                            Text(location.type),
                                            Text('${location.rating}⭐'),
                                            IconButton(
                                              icon: Icon(
                                                favorites.favoriteLocations
                                                        .contains(location)
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                              ),
                                              onPressed: () {
                                                if (favorites.favoriteLocations
                                                    .contains(location)) {
                                                  favorites.remove(location);
                                                } else {
                                                  favorites.add(location);
                                                }
                                              },
                                            ),
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

final List<MockLocation> mockLocationList = [
  MockLocation(
      id: '1',
      name: 'Place 1',
      type: 'Restaurant',
      latLng: LatLng(57.7089, 11.9746),
      rating: 4.5,
      icon: Icon(Icons.fastfood)),
  MockLocation(
      id: '2',
      name: 'Place 2',
      type: 'Park',
      latLng: LatLng(57.7044, 11.9613),
      rating: 4.7,
      icon: Icon(Icons.nature)),
  MockLocation(
      id: '3',
      name: 'Place 3',
      type: 'Museum',
      latLng: LatLng(57.6972, 11.9765),
      rating: 4.6,
      icon: Icon(Icons.museum)),
];
