import 'package:flutter/material.dart';

class ErroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ERROR'),
      ),
      body: Center(
        child: Text('These is an error, try again later'),
      ),
    );
  }
}
