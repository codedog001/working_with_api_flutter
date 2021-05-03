import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'map_result.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse = "null";
  List listResponse = ['null list'];

  Future fetchStringData() async {
    var response = await http.get(
      Uri.parse('https://thegrowingdeveloper.org/apiview?id=1'),
    );
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
      });
    }
  }

  Future fetchListData() async {
    var response = await http.get(
      Uri.parse('https://thegrowingdeveloper.org/apiview?id=4'),
    );
    if (response.statusCode == 200) {
      setState(() {
        listResponse = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Working'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                stringResponse.toString(),
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            RaisedButton(
              onPressed: fetchStringData,
              child: Text(
                'Get String Result',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Center(
              child: Text(
                listResponse.toString(),
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            RaisedButton(
              onPressed: fetchListData,
              child: Text(
                'Get List Result',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => MapResult(),
                  ),
                );
              },
              child: Text(
                'Load Map',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
