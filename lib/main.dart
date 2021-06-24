import 'package:flutter/material.dart';
import 'package:splitter_clicker/Game.dart';
import 'package:splitter_clicker/Menu.dart';
import 'package:flutter/services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);

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
