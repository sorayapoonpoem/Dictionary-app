import 'package:flutter/material.dart';
import 'package:dictionary/screens/helpers/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: TabDemo(),
    );
  }
}
