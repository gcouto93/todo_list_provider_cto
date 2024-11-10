import 'package:cto_todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:cto_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:cto_todo_list_provider/app/modules/home/home_page.dart';
import 'package:provider/provider.dart';

class HomeModule extends TodoListModule{
  HomeModule() 
  : super(
    routers: {
      '/home' : (context) => HomePage(),
    },
     bindings:[
      ChangeNotifierProvider(create: (context) => HomeController())
     ]
     );
}