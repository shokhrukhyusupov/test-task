import 'package:junior_task/services/user_service.dart';

class UserRepository {
  final UserService userService;

  UserRepository({required this.userService});

  user() {
    return userService.getUser();
  }
}