import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_task/bloc/comment_bloc/comment_bloc.dart';
import 'package:junior_task/bloc/post_bloc/post_bloc.dart';
import 'package:junior_task/bloc/post_bloc/post_state.dart';

import '../pages/post_page.dart';

class PostList extends StatelessWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      if (state is PostLoadedState) {
        return ListView.builder(
          itemCount: state.posts.length,
          itemBuilder: (context, i) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(state.posts[i].title),
                  onTap: () {
                    BlocProvider.of<CommentBloc>(context)
                        .loadComments(state.posts[i].id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostPage(post: state.posts[i]),
                      ),
                    );
                  },
                ),
                const Divider(height: 0.1, color: Colors.blueGrey),
              ],
            );
          },
        );
      } else if (state is PostLoadFailedState) {
        return Center(child: Text(state.exception));
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
