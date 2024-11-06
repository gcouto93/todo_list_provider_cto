import 'package:cto_todo_list_provider/app/core/auth/auth_provider_app.dart';
import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:cto_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:cto_todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/home_filter.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/home_header.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/home_week_filter.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToCreateTask(BuildContext context) {
    Navigator.of(context).pushNamed('task/create');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton(
            icon: Icon(TodoListIcon.filter),
            itemBuilder: (_) => [
              PopupMenuItem<bool>(child: Text('Mostrar tarefas concluídas'))
            ])
        ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: context.primaryColor,
          onPressed: () => _goToCreateTask(context),
          child: Icon(Icons.add),
          ),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeHeader(),
                      HomeFilter(),
                      HomeWeekFilter(),
                      HomeTasks()
                    ],
                  ),
                ),
              ),
              ),
          );
        }),
    );
  }
}