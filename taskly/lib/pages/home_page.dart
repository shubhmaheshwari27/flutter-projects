import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/task.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;
  String? _newTaskContent;
  Box? _box;
  _HomepageState();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text(
          "Taskly!",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: _tasksView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _tasksList() {
    //to add tasks manually
    // Task _newTask =
    //     Task(content: "Go Gym", timestamp: DateTime.now(), done: false);
    // _box?.add(_newTask.toMap());
    List tasks = _box!.values.toList();
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext _context, int _index) {
          var task = Task.fromMap(tasks[_index]);
          return ListTile(
            title: Text(
              task.content,
              style: TextStyle(
                decoration: task.done ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              task.timestamp.toString(),
            ),
            trailing: Icon(
                task.done
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank,
                color: Colors.red),
            onLongPress: () {
              _box!.delete(_index);
              setState(() {});
            },
            onTap: () {
              task.done = !task.done;
              _box!.putAt(_index, task.toMap());
              setState(() {});
            },
          );
        });

    // ListView(
    //   children: [
    //     ListTile(
    //       title: Text(
    //         "Do Laundry",
    //         style: TextStyle(
    //           decoration: TextDecoration.lineThrough,
    //         ),
    //       ),
    //       subtitle: Text(
    //         DateTime.now().toString(),
    //       ),
    //       trailing: Icon(
    //         Icons.check_box_outlined,
    //         color: Colors.red,
    //       ),
    //     )
    //   ],
    // );
  }

  Widget _tasksView() {
    return FutureBuilder(
        future: Hive.openBox("tasks!"),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            _box = _snapshot.data;
            return _tasksList();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      child: Icon(Icons.add),
    );
  }

  void _displayTaskPopup() {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          title: const Text("Add New task!"),
          content: TextField(
            onSubmitted: (_) {
              if (_newTaskContent != null) {
                var _task = Task(
                    content: _newTaskContent!,
                    timestamp: DateTime.now(),
                    done: false);
                _box!.add(
                  _task.toMap(),
                );
                setState(
                  () {
                    _newTaskContent = null;
                    Navigator.pop(context);
                  },
                );
              }
            },
            onChanged: (_value) {
              setState(
                () {
                  _newTaskContent = _value;
                },
              );
            },
          ),
        );
      },
    );
  }
}
