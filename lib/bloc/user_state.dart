import '../models/user.dart';

abstract class UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<User> users;

  UserLoadedState({this.users = const []});
}

class UserLoadFailedState extends UserState {
  final String exception;

  UserLoadFailedState(this.exception);
}
