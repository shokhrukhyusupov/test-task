import 'package:flutter/material.dart';
import 'package:junior_task/components/post_list.dart';
import 'package:junior_task/components/user_list.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Home Page',
          style: const TextStyle(fontSize: 25),
          textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1, 1),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
          child: const UserList(),
        ),
      ),
      body: const PostList(),
    );
  }
}
