import 'package:flutter/material.dart';
import 'package:dictionary/screens/helpers/dictionary.dart';
import 'package:dictionary/screens/helpers/game.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabDemo extends StatefulWidget {
  @override
  State<TabDemo> createState() => _TabDemoState();
}

class _TabDemoState extends State<TabDemo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(220, 179, 221, 1.0),
                Color.fromRGBO(163, 181, 231, 1.0)
              ]),
            ),
          ),
          title: TabBar(
            labelColor: Color.fromRGBO(255, 255, 255, 1.0),
            unselectedLabelColor: Color.fromRGBO(105, 105, 105, 1.0),
            tabs: <Tab>[
              Tab(icon: Icon(FontAwesomeIcons.book), text: 'Dictionary'),
              Tab(icon: Icon(FontAwesomeIcons.gamepad), text: 'Game'),
            ],
          ),
        ),
        body: TabBarView(children: [
          Container(
            child: const HomePage(),
          ),
          Container(
            child: Game(),
          ),
        ]),
      ),
    );
  }
}
