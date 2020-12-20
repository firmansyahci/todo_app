import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/tasks.dart';
import './providers/projects.dart';
import './screens/project_overview_screen.dart';
import './screens/tasks_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Projects(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Tasks(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProjectOverviewScreen(),
        routes: {
          TasksScreen.routeName: (ctx) => TasksScreen(),
        },
      ),
    );
  }
}
