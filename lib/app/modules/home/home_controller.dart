import 'package:cto_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:cto_todo_list_provider/app/models/task_filter_enum.dart';
import 'package:cto_todo_list_provider/app/models/task_model.dart';
import 'package:cto_todo_list_provider/app/models/total_tasks_model.dart';
import 'package:cto_todo_list_provider/app/models/week_task_model.dart';
import 'package:cto_todo_list_provider/app/services/tasks/tasks_service.dart';
import 'package:flutter/material.dart';

class HomeController extends DefaultChangeNotifier {

final TasksService _tasksService;
var filterSelected = TaskFilterEnum.today;
TotalTasksModel? todayTotalTasks;
TotalTasksModel? tomorrowTotalTasks;
TotalTasksModel? weekTotalTasks;

HomeController({required TasksService taskService}) : _tasksService = taskService;



Future<void> loadTotalTasks() async {
  final allTasks = await Future.wait([
  _tasksService.getToday(),
  _tasksService.getTomorrow(),
  _tasksService.getWeek()
  ]);

  final toDayTasks = allTasks[0] as List<TaskModel>;
  final tomorrowTasks = allTasks[1] as List<TaskModel>;
  final weekTasks = allTasks[3] as WeekTaskModel;

  todayTotalTasks = TotalTasksModel(
    totalTasks: toDayTasks.length,
     totalTasksFinish: toDayTasks.where((task) => task.finish).length);
  tomorrowTotalTasks = TotalTasksModel(
    totalTasks: tomorrowTasks.length,
     totalTasksFinish: tomorrowTasks.where((task) => task.finish).length);
  todayTotalTasks = TotalTasksModel(
    totalTasks: weekTasks.tasks.length,
     totalTasksFinish: weekTasks.tasks.where((task) => task.finish).length);
  notifyListeners();
}


}