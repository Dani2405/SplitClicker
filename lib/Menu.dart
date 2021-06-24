import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181a1e),
      appBar: AppBar(
        title: Text("Splitter Clicker", style: TextStyle(fontSize: 24)),
        backgroundColor: Color(0xFF2a2d33),
      ),
      body: Center(
        child: MaterialButton(
          child: Text("Play", style: TextStyle(color: Colors.white, fontSize: 34),),
          onPressed: () {Navigator.pushReplacementNamed(context, "/play");},
        ),
      ),
    );
  }

}