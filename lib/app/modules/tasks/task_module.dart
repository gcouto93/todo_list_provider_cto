import 'package:cto_todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:cto_todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:cto_todo_list_provider/app/modules/tasks/task_create_page.dart';
import 'package:provider/provider.dart';

class TaskModule extends TodoListModule {
  TaskModule() : super(
    bindings: [
      ChangeNotifierProvider(create: (context) => TaskCreateController()
      )
    ],
    routers: {
      '/task/create' : (context) => TaskCreatePage(
        controller: context.read(),)
    });

}