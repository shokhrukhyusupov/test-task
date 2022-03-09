import '../../models/comments.dart';

abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentLoadedState extends CommentState {
  final List<Comments> comments;

  CommentLoadedState({required this.comments});
}

class CommentLoadFailed extends CommentState {
  final String exception;

  CommentLoadFailed(this.exception);
}
