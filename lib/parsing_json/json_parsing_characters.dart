import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api_breakingbad/model/character.dart';

class JsonParsingcharactersMap extends StatefulWidget {
  const JsonParsingcharactersMap({super.key});

  @override
  State<JsonParsingcharactersMap> createState() =>
      _JsonParsingcharactersMapState();
}

class _JsonParsingcharactersMapState extends State<JsonParsingcharactersMap> {
  late Future<CharacterList> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Network network =
        Network(url: "https://www.breakingbadapi.com/api/characters");
    data = network.loadCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Character"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: data,
              builder: (context, AsyncSnapshot<CharacterList> snapshot) {
                // ignore: unused_local_variable
                List<Character> allCharacter;
                if (snapshot.hasData) {
                  allCharacter = snapshot.data!.characters;

                  return createListView(allCharacter, context); 
                } else {
                  // ignore: prefer_const_constructors
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  Widget createListView(List<Character> data, BuildContext context) {
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
                  leading: Column(children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 23,
                      child: Text('${data[index].char_id}'),
                    )
                  ]),
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

  Future<CharacterList> loadCharacter() async {
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      //OK
      return CharacterList.formJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load character');
    }
  }
}
