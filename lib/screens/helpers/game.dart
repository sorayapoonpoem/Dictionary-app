import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Matching Game",
      home: MatchingGame(),
    );
  }
}

class MatchingGame extends StatefulWidget {
  @override
  _MatchingGameState createState() => _MatchingGameState();
}

class _MatchingGameState extends State<MatchingGame> {
  List<ItemModel> items;
  List<ItemModel> items2;

  int score;
  bool gameOver;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(icon: FontAwesomeIcons.gavel, name: "Gavel", value: "Gavel"),
      ItemModel(icon: FontAwesomeIcons.flask, name: "Flask", value: "Flask"),
      ItemModel(icon: FontAwesomeIcons.paw, name: "Paw", value: "Paw"),
      ItemModel(
          icon: FontAwesomeIcons.snowflake,
          name: "Snowflake",
          value: "Snowflake"),
      ItemModel(icon: FontAwesomeIcons.wrench, name: "Wrench", value: "Wrench"),
      ItemModel(icon: FontAwesomeIcons.anchor, name: "Anchor", value: "Anchor"),
      ItemModel(icon: FontAwesomeIcons.trophy, name: "Trophy", value: "Trophy"),
      ItemModel(
          icon: FontAwesomeIcons.bullhorn, name: "Bullhorn", value: "Bullhorn"),
      ItemModel(icon: FontAwesomeIcons.rocket, name: "Rocket", value: "Rocket"),
      ItemModel(
          icon: FontAwesomeIcons.suitcase,
          name: "Suitcase ",
          value: "Suitcase "),
    ];
    items2 = List<ItemModel>.from(items);
    items.shuffle();
    items2.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    if (items.length == 0) gameOver = true;
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Score: ",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "$score",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ))
            ])),
            if (!gameOver)
              Row(
                children: <Widget>[
                  Column(
                      children: items.map((item) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Draggable<ItemModel>(
                        data: item,
                        childWhenDragging: Icon(
                          item.icon,
                          color: Colors.grey,
                          size: 50.0,
                        ),
                        feedback: Icon(
                          item.icon,
                          color: Colors.pink[200],
                          size: 50,
                        ),
                        child: Icon(
                          item.icon,
                          color: Colors.pink[300],
                          size: 50,
                        ),
                      ),
                    );
                  }).toList()),
                  Spacer(),
                  Column(
                      children: items2.map((item) {
                    return DragTarget<ItemModel>(
                      onAccept: (receivedItem) {
                        if (item.value == receivedItem.value) {
                          setState(() {
                            items.remove(receivedItem);
                            items2.remove(item);
                            score += 10;
                            item.accepting = false;
                          });
                        } else {
                          setState(() {
                            score -= 5;
                            item.accepting = false;
                          });
                        }
                      },
                      onLeave: (receivedItem) {
                        setState(() {
                          item.accepting = false;
                        });
                      },
                      onWillAccept: (receivedItem) {
                        setState(() {
                          item.accepting = true;
                        });
                        return true;
                      },
                      builder: (context, acceptedItems, rejectedItem) =>
                          Container(
                        color: item.accepting
                            ? Colors.deepPurple[200]
                            : Colors.deepPurple[300],
                        height: 50,
                        width: 120,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(8.0),
                        child: Text(
                          item.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                    );
                  }).toList()),
                ],
              ),
            if (gameOver)
              Text(
                "GameOver",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
            if (gameOver)
              Center(
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.pink,
                  child: Text("New Game"),
                  onPressed: () {
                    initGame();
                    setState(() {});
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ItemModel {
  final String name;
  final String value;
  final IconData icon;
  bool accepting;
  ItemModel(
      {this.name, this.value, this.icon, this.accepting = false, String title});
}
