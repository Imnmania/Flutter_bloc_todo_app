import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/network_service.dart';
import 'package:todo_app/data/repository.dart';
import 'package:todo_app/presentation/app_router.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
    repository: Repository(networkService: NetworkService()),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Repository repository;

  const MyApp({Key key, @required this.appRouter, @required this.repository})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosCubit(repository: repository),
        ),
        BlocProvider(
            create: (context) => AddTodoCubit(
                repository: repository,
                todosCubit: context.read<TodosCubit>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
