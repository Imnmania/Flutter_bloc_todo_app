import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/data/models/todo_model.dart';

import 'package:todo_app/data/repository.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final Repository repository;

  TodosCubit({
    @required this.repository,
  }) : super(TodosInitial());

  void fetchTodos() {
    repository.fetchTodos().then((todos) {
      emit(TodosLoaded(todos: todos));
    });
  }

  void changeCompletion(TodoModel todo) {
    repository.changeCompletion(todo.id, !todo.isCompleted).then((isChanged) {
      if (isChanged) {
        // todo.isCompleted = !todo.isCompleted;
        fetchTodos();
        updateTodoList();
      }
    });
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodosLoaded) {
      emit(TodosLoaded(todos: currentState.todos));
    }
  }

  void addTodo(TodoModel todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todos;
      todoList.add(todo);
      emit(TodosLoaded(todos: todoList));
    }
  }
}
