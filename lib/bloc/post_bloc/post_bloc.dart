import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_task/bloc/post_bloc/post_state.dart';
import 'package:junior_task/services/posts_service.dart';

class PostBloc extends Cubit<PostState> {
  final PostsService postsService;
  PostBloc({required this.postsService}) : super(PostLoadingState());

  loadPost(int id, int isTapped) async {
    emit(PostLoadingState());
    try {
      final post = await postsService.getPosts(id);
      emit(PostLoadedState(posts: post, isTapped: isTapped));
    } catch (e) {
      emit(PostLoadFailedState(e.toString()));
    }
  }
}
