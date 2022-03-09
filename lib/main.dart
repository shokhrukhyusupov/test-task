import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_task/bloc/comment_bloc/comment_bloc.dart';
import 'package:junior_task/bloc/post_bloc/post_bloc.dart';
import 'package:junior_task/pages/main_page.dart';
import 'package:junior_task/services/comments_service.dart';
import 'package:junior_task/services/posts_service.dart';
import 'package:junior_task/services/users_service.dart';

import 'bloc/user_bloc/user_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => UserBloc(usersService: UsersService())),
        RepositoryProvider(
            create: (context) => PostBloc(postsService: PostsService())),
        RepositoryProvider(
            create: (context) =>
                CommentBloc(commentsService: CommentsService())),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
