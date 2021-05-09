import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add tasks'),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is TodoAdded) {
            Navigator.pop(context);
          } else if (state is AddTodoError) {
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
        child: Padding(
          padding: EdgeInsets.all(20),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _todoController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Enter todo content...",
          ),
        ),
        SizedBox(
          height: 20,
        ),
        MaterialButton(
          child: BlocBuilder<AddTodoCubit, AddTodoState>(
            builder: (context, state) {
              if (state is AddingTodo) {
                return CircularProgressIndicator(
                  backgroundColor: Colors.white,
                );
              }
              return Text("Add");
            },
          ),
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
            final message = _todoController.text;
            BlocProvider.of<AddTodoCubit>(context).addTodo(message);
          },
        ),
      ],
    );
  }
}
