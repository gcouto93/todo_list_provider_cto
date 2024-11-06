import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:cto_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/task.dart';
import 'package:flutter/material.dart';
    
class HomeTasks extends StatefulWidget {
  const HomeTasks({Key? key}) : super(key: key);

  @override
  _HomeTasksState createState() => _HomeTasksState();
}

class _HomeTasksState extends State<HomeTasks> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text('TASK\'S DE HOJE',
          style: context.titleStyle,),
          Column(
            children: [
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
              Task(),
            ],
          )
        ],
      ), 
      );
  }
}