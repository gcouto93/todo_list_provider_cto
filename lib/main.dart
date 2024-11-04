import 'package:cto_todo_list_provider/app/app_module.dart';
import 'package:cto_todo_list_provider/app/core/application_config.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await ApplicationConfig().configureApp();
  runApp(const AppModule());
}
