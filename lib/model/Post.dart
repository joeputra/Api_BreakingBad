// ignore_for_file: public_member_api_docs, sort_constructors_first
class characterList {
  final List<Post> posts;
  characterList({
    required this.posts,
  });

  factory characterList.fromJson(List<dynamic> parsedJson) {
    List<Post> posts = <Post>[];
    posts = parsedJson.map((e) => Post.fromJson(e)).toList();

    return characterList(posts: posts); 
  }
}

class Post {
  int char_id;
  String name;
  String nickname;
  String status;
  String occupation;
  String body;
  Post({
    required this.char_id,
    required this.name,
    required this.nickname,
    required this.status,
    required this.occupation,
    required this.body,
  });

  //Factory constructor
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        char_id: json['char_id'],
        name: json['name'],
        nickname: json['nickname'],
        status: json['status'],
        occupation: json['occupation'],
        body: json['body']
        );
  }
}
