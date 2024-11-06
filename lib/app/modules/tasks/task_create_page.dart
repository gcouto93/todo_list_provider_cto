import 'package:cto_todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:flutter/material.dart';

class TaskCreatePage extends StatelessWidget {

  TaskCreateController _controller;

  TaskCreatePage({Key? key, required TaskCreateController controller}) : 
  _controller =controller, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task'),),
      body: Container(),
    );
  }
}