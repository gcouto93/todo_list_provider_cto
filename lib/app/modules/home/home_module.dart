import 'package:cto_todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:cto_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:cto_todo_list_provider/app/modules/home/home_page.dart';
import 'package:cto_todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:cto_todo_list_provider/app/repositories/tasks/task_repository.dart';
import 'package:cto_todo_list_provider/app/repositories/tasks/task_repository_impl.dart';
import 'package:cto_todo_list_provider/app/services/tasks/task_service_impl.dart';
import 'package:cto_todo_list_provider/app/services/tasks/tasks_service.dart';
import 'package:provider/provider.dart';

class HomeModule extends TodoListModule{
  HomeModule() 
  : super(
    routers: {
      '/home' : (context) => HomePage(),
    },
     bindings:[
      Provider<TaskRepository>(
        create: (context) =>
           TaskRepositoryImpl(sqliteConnectionFactory: context.read())
      ),
      Provider<TasksService>(
        create: (context) =>
           TaskServiceImpl(taskRepository: context.read())
      ),

      ChangeNotifierProvider(
        create: (context) =>
           TaskCreateController(taskService: context.read())
      ),
      ChangeNotifierProvider(create: (context) => HomeController(taskService: context.read()))
     ]
     );
}