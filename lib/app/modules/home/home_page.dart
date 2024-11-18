// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cto_todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:cto_todo_list_provider/app/models/task_filter_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:cto_todo_list_provider/app/core/auth/auth_provider_app.dart';
import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:cto_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:cto_todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:cto_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/home_filter.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/home_header.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/home_week_filter.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';
import 'package:cto_todo_list_provider/app/modules/tasks/task_create_page.dart';
import 'package:cto_todo_list_provider/app/modules/tasks/task_module.dart';

class HomePage extends StatefulWidget {
  final HomeController _homeCOntroller;
  const HomePage({ required HomeController homeController,
    Key? key,
  }) : _homeCOntroller = homeController, super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: widget._homeCOntroller).listener(
      context: context,
      successCallback: (notifier, listenerInstance) {
        listenerInstance.dispose();
      },
      );
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        widget._homeCOntroller.loadTotalTasks();
        widget._homeCOntroller.findTasks(filter: TaskFilterEnum.today);

      },);
  }

  Future<void> _goToCreateTask(BuildContext context) async {
    // Navigator.of(context).pushNamed('/task/create');
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
        return TaskModule().getPage('/task/create', context);
      },)
      );
      widget._homeCOntroller.refreshPage();
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
            onSelected: (value) {
              widget._homeCOntroller.showOrHideFinishedTasks();
            },
            itemBuilder: (_) => [
              PopupMenuItem<bool>(
                value: true,
                child: Text('${widget._homeCOntroller.showFinishedTasks ? 'Esconder' : 'Mostrar'} tarefas concluídas'),
                )
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