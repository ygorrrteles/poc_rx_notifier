import 'package:flutter/cupertino.dart';
import 'package:poc_rx_notifier/todo_model.dart';
import 'package:rx_notifier/rx_notifier.dart';

class Controller extends ChangeNotifier{
  final _todoList = RxNotifier<List<TodoModel>>([TodoModel(title: "Primeiro Todo")]);
  int get todoListSelected => _todoList.value.where((item) => item.selected == true).length;
  List<TodoModel> get todoList => _todoList.value;
  RxDisposer disposer;



  void setObserver(){
    disposer = rxObserver((){
      print("observer ${todoList.length}");
    });
  }

  @override
  void dispose() {
    disposer.call();
    super.dispose();
  }

  void add(){
    _todoList.value.add(TodoModel(title: "Novo Todo"));
    _todoList.notifyListeners();
  }

  void toggle(TodoModel model){
    model.selected = !model.selected;
    _todoList.notifyListeners();
  }

}