import 'package:cto_todo_list_provider/app/models/task_model.dart';

abstract class TaskRepository {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end);
  Future<void> chechOrUncheckTask(TaskModel task);  
  Future<void> clearDbTasks();
  Future<void> deleteTask(TaskModel task);
}