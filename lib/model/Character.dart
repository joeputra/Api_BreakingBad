// ignore_for_file: public_member_api_docs, sort_constructors_first

class CharacterList {
  final List<Character> characters;
  CharacterList({
    required this.characters,
  });

  factory CharacterList.formJson(List<dynamic> parsedJson) {
    List<Character> characters = <Character>[];
    characters = parsedJson.map((e) => Character.fromJson(e)).toList();
    return CharacterList(characters: characters);
  }
}

class Character {
  // ignore: non_constant_identifier_names
  int char_id;
  String name;
  String nickname;
  String status;
  Character({
    // ignore: non_constant_identifier_names
    required this.char_id,
    required this.name,
    required this.nickname,
    required this.status,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
        char_id: json['char_id'],
        name: json['name'],
        nickname: json['nickname'],
        status: json['status']);
  }
}
