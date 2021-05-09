import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/data/models/todo_model.dart';

class EditTodoScreen extends StatelessWidget {
  final TodoModel todo;

  EditTodoScreen({Key key, @required this.todo}) : super(key: key);

  final _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _editController.text = todo.todo;
    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        if (state is TodoEdited) {
          Navigator.pop(context);
        } else if (state is EditTodoError) {
          Toast.show(
            state.error,
            context,
            duration: 3,
            backgroundColor: Colors.black54,
            gravity: Toast.BOTTOM,
            backgroundRadius: 10,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Todo'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<EditTodoCubit>().deleteTodo(todo);
              },
            ),
          ],
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _editController,
            autocorrect: true,
            decoration: InputDecoration(
              hintText: "Enter todo message...",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            child: Text("Update"),
            height: 50,
            minWidth: double.infinity,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            highlightElevation: 0,
            splashColor: Colors.transparent,
            onPressed: () {
              context
                  .read<EditTodoCubit>()
                  .updateTodo(todo, _editController.text);
            },
          ),
        ],
      ),
    );
  }
}
