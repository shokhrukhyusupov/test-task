import 'dart:convert';

import '../models/posts.dart';
import 'package:http/http.dart' as http;

class PostsService {
  static const url = 'jsonplaceholder.typicode.com';

  Future<List<Posts>> getPosts(int id) async {
    try {
      final response =
          await http.get(Uri.https(url, '/posts', {'userId': '$id'}));
      final data = jsonDecode(response.body) as List;
      return data.map((e) => Posts.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
