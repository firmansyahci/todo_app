import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/projects.dart';
import '../screens/tasks_screen.dart';

class ProjectsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<Projects>(context).projects;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: projects.length,
      itemBuilder: (ctx, i) {
        return InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.of(context)
                .pushNamed(TasksScreen.routeName, arguments: projects[i]);
          },
          child: Container(
            padding: EdgeInsets.all(15),
            child: Text(
              projects[i].name,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
