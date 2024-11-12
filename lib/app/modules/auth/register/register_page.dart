import 'package:cto_todo_list_provider/app/app_module.dart';
import 'package:cto_todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:cto_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:cto_todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:cto_todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:cto_todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {

   const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();
  @override
  void initState() {
    super.initState();
    var defaultListener = DefaultListenerNotifier(changeNotifier: context.read<RegisterController>());
    defaultListener.listener(
      context: context,
      successCallback:(notifier, listenerInstance) {
        listenerInstance.dispose();
      },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo list',
              style: TextStyle(fontSize: 10, color: context.primaryColor),
            ),
            Text('Cadastro',
                style: TextStyle(fontSize: 15, color: context.primaryColor))
          ],
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: ClipOval(
              child: Container(
                color: context.primaryColor.withAlpha(20),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 20,
                  color: context.primaryColor,
                ),
              ),
            )),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
            child: Form(
              key: _formKey,
                child: Column(
              children: [
                TodoListField(
                  controller: emailEC,
                  label: 'E-mail',
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail obrigatório'),
                    Validatorless.email('E-mail inválido')
                  ]
                  ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                TodoListField(
                  controller: passwordEC,
                  label: 'Senha',
                  obscureText: true,
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha obrigatória'),
                    Validatorless.min(6,'Senha deve ter pelo menos 6 caracteres')
                  ]
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TodoListField(
                  controller: confirmPasswordEC,
                  label: 'Confirmar senha', obscureText: true, 
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirmação obragatoria'),
                    Validatorless.compare(passwordEC, 'Confirmação não está de acordo com senha fornecida')
                  ]
                  ),
                  ),
                
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                     var formValid = _formKey.currentState?.validate() ?? false;
                     if(formValid) {
                      var email = emailEC.text;
                      var password = passwordEC.text;
                      context.read<RegisterController>().registerUser(email, password);
                     }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Salvar',style: TextStyle(
                        color: context.primaryColorLight,
                        fontSize: 18
                        ),),
                    ),
                  ),
                )
              ],
            )),
          )
        ],
      ),
    );
  }
}
