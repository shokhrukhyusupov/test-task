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
  TextEditingController titleFormController = TextEditingController();
  TextEditingController bodyFormController = TextEditingController();
  TextEditingController emailFormController = TextEditingController();
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    autofocus: true,
                    validator: (text) => text == '' ? '?????????????? ??????????' : null,
                    controller: titleFormController,
                    decoration: InputDecoration(
                      hintText: 'Enter title',
                      labelText: 'Title',
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      border: titleFormController.text.isEmpty
                          ? OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            )
                          : OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueGrey, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    validator: (body) {
                      if (body == '') {
                        return '?????????????????? ?????? ????????';
                      } else if (body!.length < 15) {
                        return '?????? ???????? ???????????? ???????? ?????????????????? (???? ?????????? 15 ????????????????)';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter body',
                      labelText: 'Body',
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      border: bodyFormController.text.isEmpty
                          ? OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            )
                          : OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueGrey, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    controller: bodyFormController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    validator: (email) {
                      if (email == '') {
                        return '?????????????? ??????????';
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email!)) {
                        return null;
                      } else {
                        return '?????????????? ?????????????????? ??????????';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Colors.blueGrey),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      border: emailFormController.text.isEmpty
                          ? OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            )
                          : OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueGrey, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    controller: emailFormController,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<CommentBloc>(context).postComment(
                          id,
                          titleFormController.text,
                          bodyFormController.text,
                          emailFormController.text);
                      titleFormController.clear();
                      bodyFormController.clear();
                      emailFormController.clear();
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
