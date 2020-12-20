import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';
import '../providers/projects.dart';
import '../widgets/task_list.dart';
import '../widgets/new_task.dart';

class TasksScreen extends StatelessWidget {
  static const routeName = '/tasks';

  @override
  Widget build(BuildContext context) {
    final project = ModalRoute.of(context).settings.arguments as ProjectItem;

    Future<void> _refreshTasks(BuildContext context) async {
      await Provider.of<Tasks>(context, listen: false).fetchAndSetTasks();
    }

    void _addNewTask(BuildContext ctx) {
      showDialog(
          context: ctx,
          builder: (ctx) {
            return NewTask(project.id);
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
      ),
      body: FutureBuilder(
        future: _refreshTasks(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TaskList(project.id),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addNewTask(context),
      ),
    );
  }
}
