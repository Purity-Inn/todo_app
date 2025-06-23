import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskTile({super.key, 
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
Widget build(BuildContext context) {
  return AnimatedOpacity(
    opacity: 1.0,
    duration: Duration(milliseconds: 300),
    child: Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 16,
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: Checkbox(
          value: task.isDone,
          onChanged: (val) => onToggle(),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.redAccent),
          onPressed: onDelete,
        ),
      ),
    ),
  );
}
}
