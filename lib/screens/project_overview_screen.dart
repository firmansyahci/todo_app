import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/projects.dart';
import '../widgets/projects_grid.dart';

class ProjectOverviewScreen extends StatelessWidget {
  Future<void> _refreshProjects(BuildContext context) async {
    await Provider.of<Projects>(context, listen: false).fetchAndSetProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo'),
      ),
      body: FutureBuilder(
        future: _refreshProjects(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ProjectsGrid(),
      ),
    );
  }
}
