import 'package:cto_todo_list_provider/app/app_module.dart';
import 'package:cto_todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:cto_todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:cto_todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:cto_todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
            context: context,
            successCallback: (notifier, listenerInstance) {
              Messages.of(context).showInfo('Logado com sucesso');
            },
            everCallback: (notifier, listenerInstance) {
              if(notifier is LoginController) {
                if(notifier.hasInfo) {
                  Messages.of(context).showInfo(notifier.infoMessage!);
                }
              }
            }
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const TodoListLogo(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 20),
                      child: Form(
                        key: _formKey,
                          child: Column(
                        children: [
                          TodoListField(
                            label: 'E-mail',
                            controller: _emailEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Insira o E-mail'),
                              Validatorless.email('E-mail inválido')
                            ]),
                            focusNode: _emailFocus,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TodoListField(
                            label: 'Senha',
                            obscureText: true,
                            controller: _passwordEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Insira a senha'),
                              Validatorless.min(6, 'Senha contém ao menos 6 caracteres')
                            ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    
                                  if(_emailEC.text.isNotEmpty) {
                                    context.read<LoginController>().forgotPassword(_emailEC.text);
                                  } else {
                                    _emailFocus.requestFocus();
                                    Messages.of(context).showError('Digite um e-mail para recuperar a senha');
                                  }
                                  },
                                  child: const Text('Esqueceu sua senha?')),
                              ElevatedButton(
                                onPressed: () {

                                  var formValid = _formKey.currentState?.validate() ?? false;
                                  if(formValid) {
                                   final email = _emailEC.text;
                                   final password = _passwordEC.text;
                                   context.read<LoginController>().login(email, password);
                                  } else {

                                  }

                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade700,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Login',style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffF0F3F7),
                            border: Border(
                                top: BorderSide(
                                    width: 2,
                                    color: Colors.grey.withAlpha(50)))),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SignInButton(
                                text: 'Continue com o Google',
                                padding: const EdgeInsets.all(5),
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none),
                                Buttons.Google,
                                onPressed: () {
                                  context.read<LoginController>().googleLogin();
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Não tem conta?'),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/register');
                                    },
                                    child: const Text('Cadastre-se'))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
