import 'package:cto_todo_list_provider/app/app_module.dart';
import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:cto_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:cto_todo_list_provider/app/models/task_filter_enum.dart';
import 'package:cto_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWeekFilter extends StatefulWidget {
  const HomeWeekFilter({Key? key}) : super(key: key);

  @override
  _HomeWeekFilterState createState() => _HomeWeekFilterState();
}

class _HomeWeekFilterState extends State<HomeWeekFilter> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
         (controller) => controller.filterSelected == TaskFilterEnum.week),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Text('Dia da semana',style: context.titleStyle,),
          SizedBox(height: 10,),
          Container(
            height: 95,
            child: Selector<HomeController, DateTime>(
              selector: (context, controller) => controller.initialDateOfWeek ?? DateTime.now(),
              builder: (context, value, child) {
                return DatePicker(
                  value,
                  locale: 'pt_BR',
                  initialSelectedDate: value,
                  selectionColor: context.primaryColor,
                  selectedTextColor: Colors.white,
                  daysCount: 7,
                  monthTextStyle: TextStyle(fontSize: 8),
                  dayTextStyle: TextStyle(fontSize: 13),
                  dateTextStyle: TextStyle(fontSize: 13),
                  onDateChange: (date) {
                    context.read<HomeController>().filterByDay(date);
                  },
                      
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
