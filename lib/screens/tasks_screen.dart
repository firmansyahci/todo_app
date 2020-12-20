import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';
import '../providers/projects.dart';
import '../widgets/task_list.dart';

class TasksScreen extends StatelessWidget {
  static const routeName = '/tasks';

  @override
  Widget build(BuildContext context) {
    Future<void> _refreshTasks(BuildContext context) async {
      await Provider.of<Tasks>(context, listen: false).fetchAndSetTasks();
    }

    final project = ModalRoute.of(context).settings.arguments as ProjectItem;
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
    );
  }
}
