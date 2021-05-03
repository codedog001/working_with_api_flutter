import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MapResult extends StatefulWidget {
  @override
  _MapResultState createState() => _MapResultState();
}

class _MapResultState extends State<MapResult> {
  Map mapResponse = {'a': 1};
  List listOfFactsFromMap;
  String heading;

  Future fetchMapData() async {
    var response = await http.get(
      Uri.parse('https://thegrowingdeveloper.org/apiview?id=2'),
    );
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        heading = mapResponse['category'];
        listOfFactsFromMap = mapResponse['facts'];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchMapData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Result'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                heading == null ? 'ok then' : heading,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.network(listOfFactsFromMap[index]['image_url']),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        listOfFactsFromMap[index]['title'],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        listOfFactsFromMap[index]['description'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              },
              itemCount:
                  listOfFactsFromMap == null ? 0 : listOfFactsFromMap.length,
            )
          ],
        ),
      ),
    );
  }
}
