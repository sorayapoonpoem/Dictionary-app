import 'package:flutter/material.dart';

MaterialPageRoute findMeaning(
    String text, List list, Map map, BuildContext context) {
  bool check(String text) {
    for (int i = 0; i < list.length; i++) {
      if (list[i] == text) return true;
    }
    return false;
  }

  return MaterialPageRoute(
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: const Text("Meaning"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(220, 179, 221, 1.0),
              Color.fromRGBO(163, 181, 231, 1.0)
            ]),
          ),
        ),
      ),
      body: check(text)
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/meaning.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(fontSize: 50.0),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 500.0,
                    width: 500.0,
                    child: ListView.builder(
                      itemCount: map[text].split(" ").length,
                      itemBuilder: (context, int i) => Center(
                        child: InkWell(
                          child: map[text].split(" ")[i] != "or"
                              ? Text(
                                  map[text].split(" ")[i],
                                  style: TextStyle(fontSize: 17.0),
                                )
                              : Column(
                                  children: const <Widget>[
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      "OR",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text(
                "Not Found\nTry another Word",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
    ),
  );
}
