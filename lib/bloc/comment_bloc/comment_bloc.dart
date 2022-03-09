import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_task/bloc/comment_bloc/comment_state.dart';
import 'package:junior_task/models/comments.dart';
import 'package:junior_task/services/comments_service.dart';

class CommentBloc extends Cubit<CommentState> {
  final CommentsService commentsService;
  CommentBloc({
    required this.commentsService,
  }) : super(CommentLoadingState()) {
    loadComments(0);
  }

  Future<void> loadComments(int id) async {
    emit(CommentLoadingState());
    try {
      final comments = await commentsService.getComments(id);
      emit(CommentLoadedState(comments: comments));
    } catch (e) {
      emit(CommentLoadFailed(e.toString()));
    }
  }

  postComment(Map<String, dynamic> body) async {
    emit(CommentLoadingState());
    try {
      final Comments comment = await commentsService.postComments(body);
      final List<Comments> comments = []
    } catch (e) {
    }
  }
}
