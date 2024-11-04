import 'package:cto_todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:flutter/material.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final IconButton? suffixIconButton;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  TodoListField({
    super.key,
     required this.label,
     this.suffixIconButton,
     this.obscureText = false,
     this.controller,
     this.validator,
     this.focusNode
     }) :
      assert(
        obscureText == true ? suffixIconButton ==null : true,
        'obscureText não pode ser enviado em conjunto com suffixIConButton'
        ),
        obscureTextVN = ValueNotifier(obscureText),
        super();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: obscureTextVN,
        builder: (_, obscureTextValue, child) {
            return TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red),
            ),
            isDense: true,
            suffixIcon:
              suffixIconButton ??
              (obscureText == true ?
             IconButton(
              onPressed: (){
                obscureTextVN.value =  !obscureTextValue;
              },
               icon: Icon(
                !obscureTextValue ? TodoListIcon.eye_slash:TodoListIcon.eye,
                size: 15,
                ),
              )
                : null)
            ),
            obscureText: obscureTextValue,
        );
        },
    );
  }
}