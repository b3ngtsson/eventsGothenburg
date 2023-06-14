import 'package:flutter/material.dart';

import 'my_map.dart';

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
