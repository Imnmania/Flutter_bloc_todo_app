import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/data/repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final Repository repository;
  final TodosCubit todosCubit;

  EditTodoCubit({
    @required this.repository,
    @required this.todosCubit,
  }) : super(EditTodoInitial());

  void deleteTodo(TodoModel todo) {
    repository.deleteTodo(todo.id).then((isDeleted) {
      todosCubit.fetchTodos();
      emit(TodoEdited());
    });
  }

  void updateTodo(TodoModel todo, String message) {
    if (message.isEmpty) {
      emit(EditTodoError(error: "Message is Empty!"));
    }

    repository.updateTodo(message, todo.id).then((isUpdated) {
      if (isUpdated) {
        todosCubit.fetchTodos();
        emit(TodoEdited());
      }
    });
  }
}
