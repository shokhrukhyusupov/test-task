import '../../models/users.dart';

abstract class UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<Users> users;

  UserLoadedState({this.users = const []});
}

class UserLoadFailedState extends UserState {
  final String exception;

  UserLoadFailedState(this.exception);
}
