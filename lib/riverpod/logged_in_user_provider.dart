import 'package:figma_practice/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoggedInUserNotifier extends StateNotifier<List<User>> {
  LoggedInUserNotifier() : super([]);
  void logUserIn(User loggedInUser) {
    state = [...state, loggedInUser];
  }

  void logUserOut(User loggedOutUser) {
    state = state.where((user) => user.email != loggedOutUser.email).toList();
  }
}

final loggedInUserProvider =
    StateNotifierProvider<LoggedInUserNotifier, List<User>>(
        (ref) => LoggedInUserNotifier());
