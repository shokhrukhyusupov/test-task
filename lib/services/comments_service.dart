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

  Future<Comments> postComments(int id, String name, String text) async {
    try {
      final response = await http.post(
        Uri.parse(url + '/posts/$id/comments'),
        body: jsonEncode({'name': name, 'body': text, 'email': 'random@gmail.com'}),
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );
      final data =  jsonDecode(response.body);
      return Comments.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
