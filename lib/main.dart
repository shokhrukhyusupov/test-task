import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_task/bloc/user_bloc.dart';
import 'package:junior_task/pages/main_page.dart';
import 'package:junior_task/repositories/user_repository.dart';
import 'package:junior_task/services/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          UserBloc(userRepository: UserRepository(userService: UserService())),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
