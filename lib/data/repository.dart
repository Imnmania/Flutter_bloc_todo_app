import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/data/network_service.dart';

class Repository {
  final NetworkService networkService;

  Repository({this.networkService});

  Future<List<TodoModel>> fetchTodos() async {
    final todosRaw = await networkService.fetchTodos();
    return todosRaw.map((e) => TodoModel.fromJson(e)).toList();
  }

  Future<bool> changeCompletion(int id, bool isCompleted) async {
    final patchObj = {"isCompleted": isCompleted.toString()};
    return await networkService.patchTodo(patchObj, id);
  }

  Future<TodoModel> addTodo(String message) async {
    final todoObj = {
      "todo": message,
      "isCompleted": "false",
    };
    final todoMap = await networkService.addTodo(todoObj);
    if (todoMap == null) {
      return null;
    }

    return TodoModel.fromJson(todoMap);
  }

  Future<bool> deleteTodo(int id) async {
    return await networkService.deleteTodo(id);
  }

  Future<bool> updateTodo(String message, int id) async {
    final patchObj = {"todo": message};
    return await networkService.patchTodo(patchObj, id);
  }
}
