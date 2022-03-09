import 'dart:convert';

import '../models/users.dart';
import 'package:http/http.dart' as http;

class UsersService {
  static const url = 'https://jsonplaceholder.typicode.com/users';

  Future<List<Users>> getUsers() async {
    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body) as List;
      return data.map((e) => Users.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
