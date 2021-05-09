import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todos_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return Scaffold(
      appBar: AppBar(
        title: Text('TO-DO'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addTodo');
            },
          ),
        ],
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (!(state is TodosLoaded)) {
            return CircularProgressIndicator();
          }
          final todos = (state as TodosLoaded).todos;
          return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/editTodo',
                        arguments: todos[index]);
                  },
                  child: Dismissible(
                    key: Key("${todos[index].id}"),
                    background: Container(
                      color: Colors.red,
                    ),
                    confirmDismiss: (_) async {
                      context.read<TodosCubit>().changeCompletion(todos[index]);
                      return false;
                    },
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.width * 0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(todos[index].todo),
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: todos[index].isCompleted
                                    ? Colors.green
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
