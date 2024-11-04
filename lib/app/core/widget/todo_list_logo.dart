import 'package:cto_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter/material.dart';

class TodoListLogo extends StatelessWidget {
  const TodoListLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/octo-logo-IV.jpg', height: 200,),
        Text('oCto Notes', style: context.textTheme.headlineSmall)
      ],
    );
  }
}