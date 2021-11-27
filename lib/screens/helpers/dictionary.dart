import 'package:flutter/material.dart';
import 'package:dictionary/data/data.dart';
import 'package:dictionary/screens/helpers/meaning.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<String> _abbreviationKeys = [];
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _abbreviationKeys = abbreviations.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(209, 205, 240, 1.0),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextField(
              controller: _controller,
              onChanged: (t) {
                _abbreviationKeys = abbreviations.keys
                    .where((element) => element.startsWith(t))
                    .toList();
                setState(() {});
              },
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(255, 255, 255, 1.0),
                filled: true,
                border: const OutlineInputBorder(),
                hintText: 'Enter text',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    _abbreviationKeys = abbreviations.keys.toList();
                    setState(() {});
                    _controller.clear();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: _abbreviationKeys.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, i) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 10),
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: CircleAvatar(
                        child: Text(_abbreviationKeys[i][0]),
                      ),
                    ),
                    title: Text(
                      _abbreviationKeys[i],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    subtitle: Text(
                      abbreviations[_abbreviationKeys[i]] ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0),
                    ),
                    contentPadding: const EdgeInsets.all(5.0),
                    onTap: () => Navigator.of(context).push(
                      findMeaning(_abbreviationKeys[i], _abbreviationKeys,
                          abbreviations, context),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
