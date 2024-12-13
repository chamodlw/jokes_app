import 'package:flutter/material.dart';
import 'screens/jokes_screen.dart';

void main() => runApp(JokesApp());

class JokesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: JokesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
