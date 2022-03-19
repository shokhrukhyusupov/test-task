import '../../models/comments.dart';

abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentLoadedState extends CommentState {
  final List<Comments> comments;

  CommentLoadedState({this.comments = const []});
}

class CommentLoadFailed extends CommentState {
  final String exception;

  CommentLoadFailed(this.exception);
}
