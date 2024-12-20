import 'package:cto_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:cto_todo_list_provider/app/models/task_filter_enum.dart';
import 'package:cto_todo_list_provider/app/models/task_model.dart';
import 'package:cto_todo_list_provider/app/models/total_tasks_model.dart';
import 'package:cto_todo_list_provider/app/models/week_task_model.dart';
import 'package:cto_todo_list_provider/app/services/tasks/tasks_service.dart';
import 'package:flutter/material.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  var filterSelected = TaskFilterEnum.week;
  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TaskModel> allTasks= [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectedDay;
  bool showFinishedTasks = false;


  HomeController({required TasksService taskService})
      : _tasksService = taskService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek()
    ]);

    final toDayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTotalTasks = TotalTasksModel(
        totalTasks: toDayTasks.length,
        totalTasksFinish: toDayTasks.where((task) => task.finish).length);
    tomorrowTotalTasks = TotalTasksModel(
        totalTasks: tomorrowTasks.length,
        totalTasksFinish: tomorrowTasks.where((task) => task.finish).length);
    weekTotalTasks = TotalTasksModel(
        totalTasks: weekTasks.tasks.length,
        totalTasksFinish: weekTasks.tasks.where((task) => task.finish).length);
    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksService.getWeek();
        initialDateOfWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;
    }
    filteredTasks = tasks;
    allTasks = tasks;

    if(filter == TaskFilterEnum.week) {
      if(selectedDay != null) {
        filterByDay(selectedDay!);
      } else if(initialDateOfWeek != null) {
        filterByDay(initialDateOfWeek!);
      }
    } else {
      selectedDay = null;
    }

    if(!showFinishedTasks) {
      filteredTasks = filteredTasks.where((task) => !task.finish ).toList();
    }

    hideLoading();
    notifyListeners();
  }

  Future<void> filterByDay(DateTime date) async {
    selectedDay = date;
    filteredTasks = allTasks.where((task) {
      return task.dateTime == date;
    },).toList();
    notifyListeners();
  }

  void refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
  }

  Future<void> checkOrUncheckTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();
    final taskUpdate = task.copyWith(
      finish: !task.finish
    );

    await _tasksService.checkOrUncheckTask(taskUpdate);
    hideLoading();
    refreshPage();
  }

  void showOrHideFinishedTasks() {
    showFinishedTasks = !showFinishedTasks;
    refreshPage();
  }

  void deleteTask(TaskModel model) {
    _tasksService.deleteTask(model);
    refreshPage();
  }

}
