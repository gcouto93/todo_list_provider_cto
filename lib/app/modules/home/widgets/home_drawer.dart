import 'package:cto_todo_list_provider/app/core/auth/auth_provider_app.dart';
import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:cto_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:cto_todo_list_provider/app/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: context.primaryColor.withAlpha(70)),
            child: Row(
                  children: [
                    
                Selector<AuthProviderApp, String>(
                    selector: (context, authProviderApp) {
                  return authProviderApp.user?.photoURL ?? 
                    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vulture.com%2F2014%2F08%2Fmovie-review-teenage-mutant-ninja-turtles.html&psig=AOvVaw2wGY1VyIB5r6MZEK4AKKsF&ust=1730938628483000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCMCt8IO3xokDFQAAAAAdAAAAABAE';
                }, builder: (context, value, child) {
                return 
                    CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 30,
                    );}),
                     Selector<AuthProviderApp, String>(
                       selector: (context, authProviderApp) {
                        return authProviderApp.user?.displayName ?? 'Não informado';
                       },
                       builder: (context, value,child) {
                         return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                value,
                                style: context.textTheme.titleMedium,
                              ),
                            ),
                          );
                       }
                     )
                  ] 
            ),
          ),
          ListTile(
            title: Text('Alterar nome'),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Alterar Nome'),
                    content: TextField(
                      onChanged: (value) => nameVN.value = value,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                          )),
                      TextButton(
                        onPressed: () async {
                          final nameValue = nameVN.value;
                          if(nameValue.isEmpty) {
                          Messages.of(context).showError('Nome obrigatório');
                          } else {
                            Loader.show(context);
                            await context.read<UserService>().updateDisplayName(nameValue);
                            Loader.hide();
                            Navigator.of(context).pop();
                          }
                        }, child: Text('Alterar')),
                    ],
                  );
                });
            },
            ),
          ListTile(
            onTap: () => context.read<AuthProviderApp>().logout(),
            title: Text('Sair'),),
        ],
      ),
    );
  }
}
