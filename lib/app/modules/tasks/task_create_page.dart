import 'package:cto_todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:cto_todo_list_provider/app/core/ui/messages.dart';
import 'package:cto_todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:cto_todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:cto_todo_list_provider/app/modules/tasks/task_create_controller.dart';
import 'package:cto_todo_list_provider/app/modules/tasks/widgets/calendar_button.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class TaskCreatePage extends StatefulWidget {
  final TaskCreateController _controller;

  TaskCreatePage({Key? key, required TaskCreateController controller})
      : _controller = controller,
        super(key: key);

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final descriptionEx = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: widget._controller).listener(
      context: context,
      successCallback: (notifier, listenerInstance) {
        listenerInstance.dispose();
        Navigator.of(context).pop();
      },);
  }

  @override
  void dispose() {
    super.dispose();
    descriptionEx.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                try {
                  Navigator.of(context).pop();
                } on Exception catch (e) {
                  print(e.toString());
                }
              },
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ))
        ],
        // title: Text('Task'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,              
                child: Text('Criar Atividade',
                style: context.titleStyle.copyWith(
                  fontSize: 20
                ),
                ),
              ),
              SizedBox(height: 30,),
              TodoListField(
                label: '',
                controller: descriptionEx,
                validator: Validatorless.required(
                  'Descrição é obrigatória'
                ),
                ),
                SizedBox(height: 20,),
                CalendarButton()
            ],
          ),
        )),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        onPressed: (){
          final formValid = _formKey.currentState?.validate() ?? false;
          if(formValid) {
            widget._controller.save(descriptionEx.text);
          }
        },
        label: Text(
          'Salvar Task', 
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
            ),),),
          
    );
  }
}
