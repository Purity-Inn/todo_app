import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(String) onSubmit;

  const AddTaskScreen({super.key, required this.onSubmit});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _controller = TextEditingController();

  void _handleAdd() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSubmit(_controller.text.trim());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter task'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
  onPressed: _handleAdd,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.deepPurple,
    minimumSize: Size(double.infinity, 45),
  ),
  child: Text('Add Task'),
),

          ],
        ),
      ),
    );
  }
}
