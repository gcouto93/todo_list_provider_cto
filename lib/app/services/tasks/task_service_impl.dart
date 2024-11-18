import 'package:cto_todo_list_provider/app/models/task_model.dart';
import 'package:cto_todo_list_provider/app/models/week_task_model.dart';
import 'package:cto_todo_list_provider/app/repositories/tasks/task_repository.dart';
import 'package:cto_todo_list_provider/app/services/tasks/tasks_service.dart';

class TaskServiceImpl implements TasksService {

final TaskRepository _taskRepository;

TaskServiceImpl({required TaskRepository taskRepository})
  : _taskRepository = taskRepository;

  var timeNow = DateTime.now().subtract(Duration(hours: 3)); 

  @override
  Future<void> save(DateTime date, String description) => _taskRepository.save(date, description);

  @override
  Future<List<TaskModel>> getToday() {
    return _taskRepository.findByPeriod(timeNow, timeNow);
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    var tomorrowDate = timeNow.add(Duration(days: 1));
    return _taskRepository.findByPeriod(tomorrowDate, tomorrowDate);
  }

  @override
  Future<WeekTaskModel  > getWeek() async {
    final today = timeNow;
    var startFilter = DateTime(today.year, today.month, today.day,0,0,0);
    DateTime endFilter;
    if(startFilter.weekday != DateTime.monday) {
      startFilter = startFilter.subtract(Duration(days: startFilter.weekday-1));
    }

    endFilter = startFilter.add(Duration(days: 7));
    final tasks = await _taskRepository.findByPeriod(startFilter, endFilter);
    return WeekTaskModel(startDate: startFilter, endDate: endFilter, tasks: tasks);
  }
  
  @override
  Future<void> checkOrUncheckTask(TaskModel task) => _taskRepository.chechOrUncheckTask(task);

  @override
  Future<void> clearDbTasks() => _taskRepository.clearDbTasks();
  
  @override
  Future<void> deleteTask(TaskModel task) => _taskRepository.deleteTask(task);

}