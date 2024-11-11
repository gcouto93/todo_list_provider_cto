// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cto_todo_list_provider/app/models/task_model.dart';

class WeekTaskModel {
  DateTime startDate;
  DateTime endDate;
  final List<TaskModel> tasks;
  WeekTaskModel({
    required this.startDate,
    required this.endDate,
    required this.tasks,
  });
  
}
