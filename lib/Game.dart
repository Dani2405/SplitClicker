import 'dart:ui';

import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  Game({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _redCounter = 0;
  int _blueCounter = 0;
  bool _gameOver = false;

  @override
  Widget build(BuildContext context) {
    Future<bool> _checkGameOver() {
      if (_redCounter < -175 || _blueCounter < -175) {
        _gameOver = true;
        print('Game over!');
        return showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => new AlertDialog(
                  title: Text('Game Over!'),
                  content: _redCounter < -175
                      ? Text('Player 1 Won!')
                      : Text('Player 2 Won!'),
                  actions: <Widget>[
                    new GestureDetector(
                      child: MaterialButton(
                          color: Colors.lightBlueAccent,
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => super.widget));
                          },
                          child: Text(
                            "Replay?",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),new GestureDetector(
                      child: MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/menu");
                          },
                          child: Text(
                            "Exit",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ],
                ));
      }
    }

    void _incrementRed() {
      setState(() {
        if (!_gameOver) {
          _redCounter += 25;
          _blueCounter -= 25;
          print('$_redCounter vs $_blueCounter');
          _checkGameOver();
        }
      });
    }

    void _incrementBlue() {
      setState(() {
        {
          if (!_gameOver) {
            _blueCounter += 25;
            _redCounter -= 25;
            print('$_blueCounter vs $_redCounter');
            _checkGameOver();
          }
        }
      });
    }

    return Scaffold(
      backgroundColor: Color(0xFF181a1e),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Red - Player 2
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5 +
                    (_redCounter - _blueCounter),
                child: GestureDetector(
                    onTap: _incrementRed,
                    child: Container(
                      color: Colors.red,
                      child: Center(
                          child: RotatedBox(
                              quarterTurns: 2,
                              child: Text("Player 2",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32)))),
                    ))),

            // Blue - Player 1
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5 +
                    (_blueCounter - _redCounter),
                child: GestureDetector(
                    onTap: _incrementBlue,
                    child: Container(
                      color: Colors.lightBlueAccent,
                      child: Center(
                          child: Text("Player 1",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 32))),
                    )))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onBackPressed,
        tooltip: 'Go back',
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  Future<bool> onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Game over?'),
            content: new Text('This action will end the game, are you sure?'),
            actions: <Widget>[
              new GestureDetector(
                child: MaterialButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "NO",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              new GestureDetector(
                child: MaterialButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/menu");
                    },
                    child: Text(
                      "YES",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            ],
          ),
        ) ??
        false;
  }
}
