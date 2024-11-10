import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:cto_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:cto_todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
    
class CalendarButton extends StatelessWidget {

  final dateFormat = DateFormat('dd/MM/yy');

   CalendarButton({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var lastDate = DateTime.now();
        lastDate = lastDate.add(Duration(days: 10 * 365));
        
        final DateTime? selectDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: lastDate
        );

        context.read<TaskCreateController>().selectedDate =  selectDate;
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
             ),
             borderRadius: BorderRadius.circular(30)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.today,
              color: Colors.grey,),
              SizedBox(width: 10,),
              Selector<TaskCreateController, DateTime?>(
                selector: (context, controller) => controller.selectedDate,
                builder: (context, value, child) {
                  if(value !=  null) {
                    return Text(dateFormat.format(value), style: context.titleStyle,);
                  } else {
                    return Text(
                    'SELECIONE UMA DATA',
                    style: context.titleStyle,
                    );
                  }
                  
                }
              )
      
          ],
        ),
      ),
    );
  }
}