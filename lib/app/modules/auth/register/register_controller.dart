import 'package:cto_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:cto_todo_list_provider/app/exception/auth_exception.dart';
import 'package:cto_todo_list_provider/app/services/user/user_service.dart';
import 'package:flutter/material.dart';

class RegisterController extends DefaultChangeNotifier {
  final UserService _userService;

  RegisterController({required UserService userService})
      : _userService = userService;

  void registerUser(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.register(email, password);

      if (user != null) {
        succes();
      } else {
        setError(error);
      }
    } on AuthException catch (e) {
      setError(error);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
