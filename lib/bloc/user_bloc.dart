import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_task/bloc/user_state.dart';
import 'package:junior_task/repositories/user_repository.dart';

class UserBloc extends Cubit<UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserLoadingState()) {
    loadUser();
  }

  loadUser() async {
    emit(UserLoadingState());
    try {
      final user = await userRepository.user();
      emit(UserLoadedState(users: user));
    } catch (e) {
      emit(UserLoadFailedState(e.toString()));
    }
  }
}
