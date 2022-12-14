// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonparsingSimple extends StatefulWidget {
  const JsonparsingSimple({super.key});

  @override
  State<JsonparsingSimple> createState() => _JsonparsingSimpleState();
}

class _JsonparsingSimpleState extends State<JsonparsingSimple> {
  late Future data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parsing Json"),
      ),
      body: Center(
          child: Container(
        child: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return createListView(snapshot.data, context);
                //return Text(snapshot.data[0]['name']);
              } else {
                return CircularProgressIndicator();
              }
            }),
      )),
    );
  }

  Future getData() async {
    Future data;
    String url = "https://www.breakingbadapi.com/api/characters";
    Network network = Network(url: url);

    data = network.fetchData();
    // data.then((value) {
    // print(value[0]['name']);

    // });
    return data;
  }

  Widget createListView(List data, BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(height: 5.0),
            ListTile(
              title: Text("${data[index]["name"]}"),
              subtitle: Text("${data[index]["nickname"]}"),
              leading: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 23,
                    child: Text("${data[index]["char_id"]}"),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}

class Network {
  final String url;
  Network({
    required this.url,
  });

  Future fetchData() async {
    print("$url");
    Response response = await get(Uri.parse(Uri.encodeFull(url)));

    if (response.statusCode == 200) {
      //print(response.body[0]);
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
