import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/comment_bloc/comment_bloc.dart';
import '../bloc/comment_bloc/comment_state.dart';
import '../models/posts.dart';

class PostPage extends StatefulWidget {
  final Posts post;
  const PostPage({Key? key, required this.post}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController controllerOne = TextEditingController();
  TextEditingController controllerTwo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Post',
          style: const TextStyle(fontSize: 25),
          textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1, 1),
        ),
        actions: [
          TextButton(
            onPressed: () => showBottomSheet(context, widget.post.id),
            child: Text(
              'Add Comment',
              style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
              textScaleFactor:
                  MediaQuery.of(context).textScaleFactor.clamp(1, 1),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.blueGrey,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2,
                maxWidth: double.infinity,
                minHeight: 0,
                minWidth: double.infinity,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                children: [
                  Text(
                    widget.post.title,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    widget.post.body,
                    style: const TextStyle(color: Colors.white60, fontSize: 16),
                  ),
                ],
              ),
            ),
            BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
              if (state is CommentLoadedState) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.comments.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(state.comments[i].name),
                        ),
                        const Divider(height: 0.1, color: Colors.blueGrey),
                      ],
                    );
                  },
                );
              } else if (state is CommentLoadFailed) {
                return Center(child: Text(state.exception));
              }
              return const Center(child: CircularProgressIndicator());
            })
          ],
        ),
      ),
    );
  }

  showBottomSheet(BuildContext context, int id) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Form(
          key: formKey,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (text) => text == '' ? 'Введите текст' : null,
                  controller: controllerOne,
                  decoration: const InputDecoration(
                    hintText: 'comment'
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (text) => text == '' ? 'Введите текст' : null,
                  decoration: const InputDecoration(
                    hintText: 'email'
                  ),
                  controller: controllerTwo,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<CommentBloc>(context).postComment(
                          id, controllerOne.text, controllerTwo.text);
                      controllerOne.clear();
                      controllerTwo.clear();
                      setState(() {});
                    }
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
