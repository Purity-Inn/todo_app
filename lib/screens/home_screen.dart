import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task_screen.dart';
import '../widgets/task_tile.dart';
import '../utils/storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final savedTasks = await TaskStorage.loadTasks();
    setState(() {
      tasks = savedTasks;
    });
  }

  void _saveTasks() {
    TaskStorage.saveTasks(tasks);
  }

  void _addNewTask(String taskTitle) {
    setState(() {
      tasks.add(Task(title: taskTitle));
    });
    _saveTasks();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task added')),
    );
  }

  void _toggleTask(int index) {
    setState(() {
      tasks[index].toggleDone();
    });
    _saveTasks();
  }

  void _deleteTask(int index) {
    String deletedTitle = tasks[index].title;
    setState(() {
      tasks.removeAt(index);
    });
    _saveTasks();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted "$deletedTitle"')),
    );
  }

  void _openAddTaskScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(onSubmit: _addNewTask),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text(
                'No tasks yet. Add some!',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => TaskTile(
                task: tasks[index],
                onToggle: () => _toggleTask(index),
                onDelete: () => _deleteTask(index),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTaskScreen,
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
    );
  }
}

