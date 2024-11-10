import 'package:cto_todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:flutter/material.dart';

class SqliteAdmConnection with WidgetsBindingObserver{
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    
      final connection = SqliteConnectionFactory();
    switch(state) {
      case AppLifecycleState.resumed:
      connection.openConnection();
      break;      
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;
      case AppLifecycleState.hidden:
      
    }
    super.didChangeAppLifecycleState(state);
  }
 }