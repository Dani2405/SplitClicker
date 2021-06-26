import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'dart:async';

class Game extends StatefulWidget {
  Game({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with ChangeNotifier  {
  int _redCounter = 0;
  int _blueCounter = 0;
  int increment = 15;

  String countdown = "3";

  bool _gameOver = false;
  bool _show = true;
  bool _showPause = false;

  @override
  Widget build(BuildContext context) {
    Future<bool> _checkGameOver() {
      if (_redCounter < -(MediaQuery
          .of(context)
          .size
          .height / 4) + 40 ||
          _blueCounter < -(MediaQuery
              .of(context)
              .size
              .height / 4) + 32) {
        _gameOver = true;
        return showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) =>
            new AlertDialog(
              backgroundColor: Color(0xFF181a1e),
              title:
              Text('Game Over!', style: TextStyle(color: Colors.white)),
              content: _redCounter < -175
                  ? Text('Player 1 Won!',
                  style: TextStyle(color: Colors.white))
                  : Text('Player 2 Won!',
                  style: TextStyle(color: Colors.white)),
              actions: <Widget>[
                new GestureDetector(
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/menu");
                      },
                      child: Text(
                        "Exit",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                new GestureDetector(
                  child: MaterialButton(
                      color: Colors.lightBlueAccent,
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                super.widget));
                      },
                      child: Text(
                        "Replay",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ));
      }
    }

    void _incrementRed() {
      setState(() {
        if (!_gameOver) {
          _redCounter += increment;
          _blueCounter -= increment;
          _checkGameOver();
        }
      });
    }

    double _getRedSize() {
      return (MediaQuery
          .of(context)
          .size
          .height) / 2 +
          (_redCounter - _blueCounter);
    }

    void _incrementBlue() {
      setState(() {
        {
          if (!_gameOver) {
            _blueCounter += increment;
            _redCounter -= increment;
            _checkGameOver();
          }
        }
      });
    }

    double _getBlueSize() {
      return (MediaQuery
          .of(context)
          .size
          .height) / 2 +
          (_blueCounter - _redCounter);
    }

    void startGame() {
      setState(() {{
          _show = false;
          _showPause = true;
        }}
        );
    }

    return Scaffold(
      backgroundColor: Color(0xFF181a1e),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Red - Player 2
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                        onTap: _incrementRed,
                        child: AnimatedContainer(
                          height: _getRedSize(),
                          duration: const Duration(milliseconds: 175),
                          curve: Curves.easeIn,
                          color: Color(0xFFff5a4f),
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
                    child: InkWell(
                        onTap: _incrementBlue,
                        child: AnimatedContainer(
                          height: _getBlueSize(),
                          duration: const Duration(milliseconds: 175),
                          curve: Curves.easeIn,
                          color: Colors.lightBlueAccent,
                          child: Center(
                              child: Text("Player 1",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32))),
                        )))
              ],
            ),
            Visibility(
              visible: _show,
              child: Opacity(
                opacity: 0.75,
                child: SizedBox(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xFF181a1e),
                      child: Center(
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.bounceInOut,
                            child: Countdown(
                              duration: Duration(seconds: 3),
                              onFinish: () {
                                startGame();
                              },
                              builder: (BuildContext ctx, Duration remaining) {
                                  return Text('${remaining.inSeconds != 0 ? remaining.inSeconds : 'GO'}',
                                      style: TextStyle(
                                          fontSize: 225, color: Colors.white));
                              },
                            ),
                          ))),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: _showPause,
        child: SizedBox(
          width: 45,
          child: Center(
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: pause,
              tooltip: 'Pause',
              child: Icon(
                Icons.pause,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }

  Future<bool> pause() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) =>
      new AlertDialog(
        backgroundColor: Color(0xFF181a1e),
        title: new Text('Paused', style: TextStyle(color: Colors.white)),
        content: new Text('Do you want to end the game?',
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          new GestureDetector(
            child: MaterialButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/menu");
                },
                child: Text(
                  "YES",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          new GestureDetector(
            child: MaterialButton(
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "NO",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    ) ??
        false;
  }
}
