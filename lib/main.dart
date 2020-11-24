import 'package:flutter/material.dart';
import 'package:jsontodart/homePage.dart';

void main() async {
  runApp(JsonToDart());
}

class JsonToDart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
