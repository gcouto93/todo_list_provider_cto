import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:cto_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter/material.dart';
    
class TodoCardFilter extends StatefulWidget {
  const TodoCardFilter({Key? key}) : super(key: key);

  @override
  _TodoCardFilterState createState() => _TodoCardFilterState();
}

class _TodoCardFilterState extends State<TodoCardFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 120,
        maxWidth: 150
      ),
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.primaryColor,
        border: Border.all(width: 1, color: Colors.grey.withOpacity(.8),
        ),
        borderRadius: BorderRadius.circular(30),
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('10 TASKS',
          style: context.titleStyle.copyWith(
            fontSize: 10,
            color: Colors.white
          ),
          ),
          SizedBox(height: 5,),
          Text(
            'Hoje', 
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
          SizedBox(height: 5,),
          LinearProgressIndicator(
            backgroundColor: context.primaryColorLight,
            value: .4,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      ),
    );
  }
}