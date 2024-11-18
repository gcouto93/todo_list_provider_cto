import 'package:cto_todo_list_provider/app/app_module.dart';
import 'package:cto_todo_list_provider/app/models/task_model.dart';
import 'package:cto_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/y');
  Task({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.grey)]),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(onLongPress: () {
          showDialog(
            context: context,
            builder:(_) {
              return AlertDialog(
              title: Text('Deseja excluir esse item?'),
              actions: [
                TextButton(onPressed: () {
                  context.read<HomeController>().deleteTask(model);
                  Navigator.of(context).pop();
                }, child: Text('Confirmar'),),

              ],
            );
          },);
        },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(width: 1)
          ),
          contentPadding: EdgeInsets.all(8),
          leading: Checkbox(
            value: model.finish,
            onChanged: (value) => context.read<HomeController>().checkOrUncheckTask(model),
          ),
          title: Text(
            model.description,
            style: TextStyle(
                decoration: model.finish ? TextDecoration.lineThrough : null),
          ),
          subtitle: Text(
            dateFormat.format(model.dateTime),
            style: TextStyle(
                decoration: model.finish ? TextDecoration.lineThrough : null)
            ),),
        ),
      );    
  }
}
