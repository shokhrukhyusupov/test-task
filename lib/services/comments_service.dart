import 'dart:convert';

import 'package:junior_task/models/comments.dart';
import 'package:http/http.dart' as http;

class CommentsService {
  static const url = 'https://jsonplaceholder.typicode.com';

  Future<List<Comments>> getComments(int id) async {
    try {
      final response = await http.get(Uri.parse(url + '/posts/$id/comments'));
      final data = jsonDecode(response.body) as List;
      return data.map((e) => Comments.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Comments> postComments(int id, String title, String body, String email) async {
    final String json = jsonEncode({'name': title, 'body': body, 'email': email});
    final response = await http.post(
      Uri.parse(url + '/posts/$id/comments'),
      body: utf8.encode(json),
      headers: {'Content-type': 'application/json; charset=UTF-8'},
    );
    final data = jsonDecode(response.body);
    return Comments.fromJson(data);
  }
}
