import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/favorites.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Consumer<Favorites>(
        builder: (context, favorites, _) => ListView.builder(
          itemCount: favorites.favoriteLocations.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(favorites.favoriteLocations[index].name),
            // Add other information about the location here...
          ),
        ),
      ),
    );
  }
}
