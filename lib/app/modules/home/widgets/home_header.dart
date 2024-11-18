import 'package:cto_todo_list_provider/app/core/auth/auth_provider_app.dart';
import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:cto_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Selector<AuthProviderApp, String>(
        selector: (context, authProvider) {
          return authProvider.user?.displayName ?? 'Não informado';
        },
        builder: (context, value,child) {
          return Text(
            'E aí, meu chapa: $value!',
            style: 
              context.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold
              )
            ,);
        }
      ),
    );
  }
}