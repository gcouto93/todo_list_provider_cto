import 'package:cto_todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:cto_todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:cto_todo_list_provider/app/modules/auth/login/login_page.dart';
import 'package:cto_todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:cto_todo_list_provider/app/modules/auth/register/register_page.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AuthModule extends TodoListModule{
  AuthModule() : super(
    bindings: [
      ChangeNotifierProvider(
        create: (context) => LoginController(userService: context.read()),        
        ),
      ChangeNotifierProvider(
        create: (context) => RegisterController(userService: context.read()),        
        ),
    ],
    routers: {
      '/login' : (context) => const LoginPage(),
      '/register' : (context) => RegisterPage()
    });
}