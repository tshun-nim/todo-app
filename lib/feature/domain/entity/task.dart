import 'package:uuid/uuid.dart';

class Task {
  final Uuid id;
  final String task;
  bool isComplete = false;

  Task(this.task) : id = Uuid();
}