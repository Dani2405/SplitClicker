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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
          child: MaterialButton(
            highlightColor: Colors.blue,
            splashColor: Colors.black,
            child: Text(
              "Play",
              style: TextStyle(color: Colors.white, fontSize: 56),
            ),
            onPressed: () {Navigator.pushReplacementNamed(context, "/play");},
          ),
        ),
      ),
    );
  }
}
