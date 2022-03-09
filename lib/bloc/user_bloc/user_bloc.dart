import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_task/bloc/user_bloc/user_state.dart';
import 'package:junior_task/services/users_service.dart';

class UserBloc extends Cubit<UserState> {
  final UsersService usersService;
  UserBloc({required this.usersService}) : super(UserLoadingState()) {
    loadUser();
  }

  loadUser() async {
    emit(UserLoadingState());
    try {
      final user = await usersService.getUsers();
      emit(UserLoadedState(users: user));
    } catch (e) {
      emit(UserLoadFailedState(e.toString()));
    }
  }
}
