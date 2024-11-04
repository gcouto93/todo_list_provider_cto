import 'package:cto_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:cto_todo_list_provider/app/exception/auth_exception.dart';
import 'package:cto_todo_list_provider/app/services/user/user_service.dart';
import 'package:flutter/material.dart';

class LoginController extends DefaultChangeNotifier{
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService}) 
      : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> googleLogin() async {
    try {
  showLoadingAndResetState();
  infoMessage = null;
  notifyListeners();
  final user = await _userService.googleLogin();
  if(user != null) {
    succes();
  } else {
    _userService.logout();
    setError('Erro ao realizar login com Google');
  }
} on AuthException catch (e) {
  _userService.logout();
  setError(e.message);
} finally {
  hideLoading();
  notifyListeners();
}
  }

  void login(String email, String password) async {
    try {
  showLoadingAndResetState();
  infoMessage = null;
  notifyListeners();
  
  final user = await _userService.login(email, password);
  if(user != null) {
    succes();
  } else {
    setError('Usuário ou senha inválidos');
  }
} on AuthException catch (e) {
  setError(e.message);
}finally {
  hideLoading();
  notifyListeners();
}
    
  }

  Future<void> forgotPassword(String email) async {
    try {
  showLoadingAndResetState();
  infoMessage = null;
  await _userService.forgotPassword(email);
  infoMessage = 'Reset de senha enviado para seu e-mail'; 
} on Exception {
  setError('Erro ao resetar a senha');
} finally {
  hideLoading();
  notifyListeners();
}
  }
    

}