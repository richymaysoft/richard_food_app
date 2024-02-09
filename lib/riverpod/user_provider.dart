import 'package:figma_practice/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<List<User>> {
  UserNotifier()
      : super([
          const User(
              name: 'Richard Imafidon',
              email: 'user1@email.com',
              password: '123456'),
        ]);

  void addUser(User user) {
    state = [...state, user];
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, List<User>>((ref) => UserNotifier());
