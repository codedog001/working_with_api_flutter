import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String stringResponse = "null";

  Future fetchData() async {
    var response = await http.get(
      Uri.parse('https://thegrowingdeveloper.org/apiview?id=1'),
    );
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Working'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            onPressed: fetchData,
            child: Text(
              'Get String Result',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
