import 'package:flutter/material.dart';

import '../models/user.dart';

class TasksPage extends StatelessWidget {
  final User user;
  const TasksPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(user.title)),
    );
  }
}
