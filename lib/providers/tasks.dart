import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskItem {
  final int id;
  final int projectId;
  final String content;

  TaskItem({
    @required this.id,
    @required this.projectId,
    @required this.content,
  });
}

class Tasks with ChangeNotifier {
  List<TaskItem> _tasks = [];

  List<TaskItem> get tasks {
    return [...tasks];
  }

  Future<void> fetchAndSetTasks() async {
    final url = 'https://api.todoist.com/sync/v8/sync';
    final data = {
      'token': 'a3f9fe69240f859f983783df9e764c1beebe5190',
      'sync_token': '*',
      'resource_types': '["items"]',
    };
    try {
      final response = await http.post(
        url,
        body: data,
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      print(extractedData);
      final List<TaskItem> loadedTasks = [];
      final taskData = extractedData['items'];
      taskData.forEach((value) {
        loadedTasks.add(
          TaskItem(
            id: value['id'],
            projectId: value['project_id'],
            content: value['content'],
          ),
        );
      });
      _tasks = loadedTasks;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<TaskItem> findByProjectId(int projId) {
    return _tasks.where((task) => task.projectId == projId).toList();
  }
}
