import 'package:flutter/material.dart';
import 'package:poc_rx_notifier/controller.dart';
import 'package:rx_notifier/rx_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final todoController = Controller()..setObserver();

  @override
  Widget build(BuildContext context) {
    print("rebuildando");
    return Scaffold(
      appBar: AppBar(
        title: RxBuilder(
          filter:() => todoController.todoListSelected > 3 ,
          builder: (context) => Text("Lista Rx ${todoController.todoListSelected}"),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home2()));
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              todoController.add();
              print(todoController.todoList.length);
            },
          ),
        ],
      ),
      body: RxBuilder(
        builder: (context) => ListView.builder(
          itemCount: todoController.todoList.length,
          itemBuilder: (context, index) {
            final item = todoController.todoList[index];
            return CheckboxListTile(
              title: Text(item.title),
              value: item.selected,
              onChanged: (_) => todoController.toggle(item),
            );
          },
        ),
      ),
    );
  }
}


class Home2 extends StatefulWidget {

  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  final todoController = Controller()..setObserver();


  @override
  void dispose() {
    super.dispose();
    todoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
