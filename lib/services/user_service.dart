import 'dart:convert';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<User>> getUser() async {
    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body) as List;
      return data.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
