import 'package:cto_todo_list_provider/app/core/auth/auth_provider_app.dart';
import 'package:cto_todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'),),
      drawer: HomeDrawer(),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.read<AuthProviderApp>().logout();
          },
           child: Text('Logout')),
      ),
    );
  }
}