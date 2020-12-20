import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks.dart';

class NewTask extends StatefulWidget {
  final int projId;

  NewTask(this.projId);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _taskController = TextEditingController();
  var _isLoading = false;

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_taskController.text);
    return AlertDialog(
      title: Text('Add task'),
      content: TextField(
        controller: _taskController,
      ),
      actions: [
        FlatButton(
          onPressed: _isLoading
              ? null
              : () async {
                  setState(() {
                    _isLoading = true;
                  });
                  if (_taskController.text.isEmpty) {
                    Navigator.of(context).pop();
                    return;
                  }
                  Provider.of<Tasks>(context, listen: false)
                      .addTask(widget.projId, _taskController.text)
                      .then((value) {
                    Navigator.of(context).pop();
                  });
                },
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Text('Add'),
        ),
      ],
    );
  }
}
