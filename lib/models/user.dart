class User {
  final int userId;
  final int id;
  final String title;
  final String body;

  User({
    required this.userId,
    required this.title,
    required this.id,
    required this.body,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      title: json['title'],
      id: json['id'],
      body: json['body'],
    );
  }
}
