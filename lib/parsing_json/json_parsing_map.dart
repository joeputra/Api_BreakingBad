import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api_breakingbad/model/Post.dart';

class JsonparsingMap extends StatefulWidget {
  const JsonparsingMap({super.key});

  @override
  State<JsonparsingMap> createState() => _JsonparsingMapState();
}

class _JsonparsingMapState extends State<JsonparsingMap> {
  late Future<characterList> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Network network =
        Network(url: "https://www.breakingbadapi.com/api/characters");
    data = network.loadcharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Character Breaking Bad"),
      ),
      body: Center(
          child: Container(
        child: FutureBuilder(
            future: data, 
            builder: ((context, AsyncSnapshot<characterList> snapshot) {
              List<Post> allPosts;
              if (snapshot.hasData) {
                allPosts = snapshot.data!.posts;
                return Text("${allPosts[0].name}");
              } else {
                return CircularProgressIndicator();
              }
            })),
      )),
    );
  }

  Widget createListView(List<Post> data, BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, int index) {
            return Column(
              children: [
                Divider(
                  height: 5.0,
                ),
                ListTile(
                  title: Text("${data[index].name}"),
                  subtitle: Text("${data[index].nickname}"),
                  leading: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 23,
                        child: Text('${data[index].char_id}'),
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

  Future<characterList> loadcharacters() async {
    final Response response = await get(Uri.parse(Uri.encodeFull(url)));

    if (response.statusCode == 200) {
      return characterList.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get Character");
    }
  }
}
