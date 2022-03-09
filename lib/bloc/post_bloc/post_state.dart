import '../../models/posts.dart';

abstract class PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<Posts> posts;
  final int isTapped;
  PostLoadedState({this.posts = const [], this.isTapped = 0});
}

class PostLoadFailedState extends PostState {
  final String exception;

  PostLoadFailedState(this.exception);
}
