import 'package:flutter/material.dart';
import 'package:todo_app/feature/domain/entity/task.dart';
import 'package:todo_app/feature/presentation/complete_list_page.dart';
import 'package:todo_app/feature/presentation/task_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoアプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Todoアプリ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Task> taskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // title: const Text('タブのタイトル'),
            title: const TabBar(
            // bottom: const TabBar(
              tabs: <Widget>[
                // Tab(icon: Icon(Icons.cloud_outlined)),
                // Tab(icon: Icon(Icons.beach_access_sharp)),
                Tab(text: "タスク",),
                Tab(text: "完了",),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Center(child: TaskListPage(taskList: taskList),),
              Center(child: CompleteListPage(taskList: taskList)),
            ],
          ),
        ),
      ),
      
      
      
       
    );
  }  
}
