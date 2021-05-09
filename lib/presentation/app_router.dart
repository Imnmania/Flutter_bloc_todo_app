import 'package:flutter/material.dart';
// import 'package:todo_app/data/network_service.dart';
// import 'package:todo_app/data/repository.dart';
import 'package:todo_app/presentation/screens/add_todo.dart';
import 'package:todo_app/presentation/screens/edit_todo.dart';
import 'package:todo_app/presentation/screens/home_screen.dart';

class AppRouter {
  // NetworkService repository;

  // AppRouter() {
  //   repository = NetworkService();
  //   repository.fetchTodos();
  // }

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;

      case '/addTodo':
        return MaterialPageRoute(builder: (_) => AddTodoScreen());
        break;

      case '/editTodo':
        return MaterialPageRoute(builder: (_) => EditTodoScreen());
        break;

      default:
        return null;
    }
  }
}
