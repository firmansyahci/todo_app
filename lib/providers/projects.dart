import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProjectItem {
  final int id;
  final String name;

  ProjectItem({
    @required this.id,
    @required this.name,
  });
}

class Projects with ChangeNotifier {
  List<ProjectItem> _projects = [];

  List<ProjectItem> get projects {
    return [..._projects];
  }

  Future<void> fetchAndSetProjects() async {
    final url = 'https://api.todoist.com/sync/v8/sync';
    final data = {
      'token': 'a3f9fe69240f859f983783df9e764c1beebe5190',
      'sync_token': '*',
      'resource_types': '["projects"]',
    };
    try {
      final response = await http.post(
        url,
        body: data,
      );
      if (response.statusCode != 200) {
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<ProjectItem> loadedProject = [];
      final projectData = extractedData['projects'];
      projectData.forEach((value) {
        loadedProject.add(
          ProjectItem(
            id: value['id'],
            name: value['name'],
          ),
        );
      });
      _projects = loadedProject;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
