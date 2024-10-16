import 'package:flutter/material.dart';
import 'package:todo_app/feature/domain/entity/task.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key, required this.taskList});
  
  final List<Task> taskList;

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            for (final t in widget.taskList)
              if (!t.isComplete)                 
                Row(
                  children: [
                    Checkbox(
                      value: t.isComplete,
                      onChanged: (value) {
                        setState(() {
                          t.isComplete = value!;
                        });
                        final snackBar = SnackBar(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("「${t.task}」を完了しました。" ),
                              TextButton(
                                onPressed: (){
                                  setState(() {
                                    t.isComplete = false;
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  });
                                },
                                child: Text("元に戻す"),
                              ),
                            ],
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    ),
                    Text(t.task),
                  ],
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: '新規作成',
        child: const Icon(Icons.add),
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