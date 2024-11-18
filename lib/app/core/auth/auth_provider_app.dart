import 'package:cto_todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:cto_todo_list_provider/app/core/navigator/todo_list_navigator.dart';
import 'package:cto_todo_list_provider/app/services/user/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProviderApp extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;
  final SqliteConnectionFactory _sqliteConnectionFactory;

  AuthProviderApp({required FirebaseAuth firebaseAuth, required UserService userService,required SqliteConnectionFactory sqliteConnectionFactory}) 
  : _firebaseAuth = firebaseAuth,
    _userService = userService,
    _sqliteConnectionFactory = sqliteConnectionFactory;

    Future<void> logout() async {
      var conn = await _sqliteConnectionFactory.openConnection();
      conn.delete('todo');
      return _userService.logout();}

    User? get user => _firebaseAuth.currentUser;

    void loadListener() {
      _firebaseAuth.userChanges().listen((_) => notifyListeners());
      _firebaseAuth.authStateChanges().listen((user) {
        if(user != null) {
          TodoListNavigator.to.pushNamedAndRemoveUntil('/home',(route) => false);

        } else {
          TodoListNavigator.to.pushNamedAndRemoveUntil('/login',(route) => false);
        }
      });
    }

}