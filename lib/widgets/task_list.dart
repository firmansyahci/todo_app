import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';

class TaskList extends StatelessWidget {
  final int projectId;

  TaskList(this.projectId);

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context).findByProjectId(projectId);
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (ctx, i) => Column(
        children: [
          ListTile(
            title: Text(tasks[i].content),
          ),
          Divider(),
        ],
      ),
    );
  }
}
