import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.grey)]),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(width: 1)
          ),
          contentPadding: EdgeInsets.all(8),
          leading: Checkbox(value: true, onChanged: (value) {}),
          title: Text(
            'Descrição da task',
            style: TextStyle(
                decoration: false ? TextDecoration.lineThrough : null),
          ),
          subtitle: Text(
            '28/2/24',
            style: TextStyle(
                decoration: false ? TextDecoration.lineThrough : null)
            ),),
        ),
      );    
  }
}
