class Posts {
  final int userId;
  final int id;
  final String title;
  final String body;

  Posts({
    required this.userId,
    required this.title,
    required this.id,
    required this.body,
  });

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        userId: json['userId'],
        title: json['title'],
        id: json['id'],
        body: json['body'],
      );
}
