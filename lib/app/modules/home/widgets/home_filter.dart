import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:cto_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';
import 'package:flutter/material.dart';
    
class HomeFilter extends StatefulWidget {

  const HomeFilter({ Key? key }) : super(key: key);

  @override
  State<HomeFilter> createState() => _HomeFilterState();
}

class _HomeFilterState extends State<HomeFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.titleStyle,
          ),
          SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TodoCardFilter()
              ],
            ),
          )
      ],
    );
  }
}