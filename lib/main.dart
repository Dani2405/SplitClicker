import 'package:flutter/material.dart';
import 'package:splitter_clicker/Game.dart';
import 'package:splitter_clicker/Menu.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splitter Clicker',
      home: Menu(),
      routes: {
        '/menu': (context) => Menu(),
        '/play': (context) => Game(),
      },
    ),
  );
}
