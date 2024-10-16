import 'package:flutter/material.dart';
import 'package:todo_app/feature/domain/entity/task.dart';

class CompleteListPage extends StatefulWidget {
  const CompleteListPage({super.key, required this.taskList});
  
  final List<Task> taskList;

  @override
  State<CompleteListPage> createState() => _CompleteListPageState();
}

class _CompleteListPageState extends State<CompleteListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            for (final t in widget.taskList)
              if (t.isComplete)                 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(t.task),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              t.isComplete = false;
                            });
                          },
                          child: const Text('元に戻す'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.taskList.removeWhere((task) => task.id == t.id);
                            });
                          },
                          child: const Text('削除'),
                        ),
                      ],
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }

  void _addTodo() {
    // TextEditingControllerを作成
    TextEditingController textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('新規タスク'),
          content: TextField(
            controller: textFieldController,
            decoration: const InputDecoration(hintText: 'タスクを入力してください'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // TextFieldに入力された値を取得
                String inputText = textFieldController.text;
                setState(() {
                  if (inputText != "") {
                    final newTask = Task(inputText);
                    widget.taskList.add(newTask);
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}