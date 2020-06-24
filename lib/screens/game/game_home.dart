import 'dart:async';
import 'package:academy/shared/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

int level = 8;

class GameHome extends StatefulWidget {
  final int size;
  const GameHome({Key key, this.size = 8}) : super(key: key);
  @override
  _GameHomeState createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<String> data = [];
  int previousIndex = -1;
  bool flip = false;

  int time = 0;
  Timer timer;

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        time = time + 1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }
    for (var i = 0; i < widget.size / 2; i++) {
      data.add((i + 1).toString());
      data.add((i + 1).toString());
    }
    startTimer();
    data.shuffle();
  }

  showResult() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text('Won!!'),
              content: Text("Time: $time"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      level *= 2;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => MainMenu(widgetIndex: 4)));
                    },
                    child: Text('Try Again'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "$time",
                  style: TextStyle(fontSize: 28.0),
                ),
              ),
              Theme(
                data: ThemeData.dark(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => FlipCard(
                      key: cardStateKeys[index],
                      onFlip: () {
                        if (!flip) {
                          flip = true;
                          previousIndex = index;
                        } else {
                          flip = false;
                          if (previousIndex != index) {
                            if (data[previousIndex] != data[index]) {
                              cardStateKeys[previousIndex]
                                  .currentState
                                  .toggleCard();
                              previousIndex = index;
                            } else {
                              cardFlips[previousIndex] = false;
                              cardFlips[index] = false;
                              if (cardFlips
                                  .every((element) => element == false)) {
                                timer.cancel();
                                showResult();
                              }
                            }
                          }
                        }
                      },
                      direction: FlipDirection.HORIZONTAL,
                      flipOnTouch: cardFlips[index],
                      front: Container(
                        margin: EdgeInsets.all(4.0),
                        color: Colors.deepOrange.withOpacity(0.3),
                      ),
                      back: Container(
                        margin: EdgeInsets.all(4.0),
                        color: Colors.deepOrange,
                        child: Center(
                          child: Text(
                            '${data[index]}',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                    ),
                    itemCount: data.length,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
