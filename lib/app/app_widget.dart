import 'package:cto_todo_list_provider/app/core/database/sqlite_adm_connection.dart';
import 'package:cto_todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:cto_todo_list_provider/app/core/navigator/todo_list_navigator.dart';
import 'package:cto_todo_list_provider/app/core/ui/todo_list_ui_config.dart';
import 'package:cto_todo_list_provider/app/modules/auth/auth_module.dart';
import 'package:cto_todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:cto_todo_list_provider/app/modules/home/home_module.dart';
import 'package:cto_todo_list_provider/app/modules/splash/splash_page.dart';
import 'package:cto_todo_list_provider/app/modules/tasks/task_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  final sqliteAdmConnection = SqliteAdmConnection();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(sqliteAdmConnection);
    SqliteConnectionFactory().openConnection();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);  
    super.dispose();
  }
  
  @override Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Provider',
      // initialRoute: '/login',
      navigatorKey: TodoListNavigator.navigatorKey,
      theme: TodoListUiConfig.theme,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),

      ],
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
        ...TaskModule().routers
      },
      home: const SplashPage(),
    );
  }
}