import 'package:dio/dio.dart';
import 'package:final_examination/core/theme.dart';
import 'package:final_examination/presentation/widgets/todo/todo_widgets.dart';
import 'package:final_examination/data/repositories/repositories.dart';
import 'package:final_examination/logic/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosScreen extends StatefulWidget {
  static const routeName = '/todos';

  final String userId;

  const TodosScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => TodoBloc(
          todoRepository: TodoRepository(
            userId: widget.userId,
            dio: Dio(),
          ),
        )..add(TodoStarted()),
        child: Scaffold(
          body: BlocConsumer<TodoBloc, TodoState>(
            listener: (context, state) {
              if (state is TodoLoadFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.exception.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is TodoLoadInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TodoLoadSuccess) {
                animationController.forward();

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 72,
                        bottom: 48,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TweenAnimationBuilder(
                            curve: Curves.easeInOut,
                            tween: Tween<double>(begin: 0, end: 24),
                            duration: const Duration(seconds: 1),
                            builder: (context, double value, child) => Text(
                              'TODO APP',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: value,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          MaterialButton(
                            padding: const EdgeInsets.all(0),
                            color: AppTheme.primaryColorDark,
                            shape: const CircleBorder(),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) => BlocProvider.value(
                                  value: context.read<TodoBloc>(),
                                  child: const TodoAddModalBottomSheet(),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 1.5),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animationController,
                              curve: Curves.easeInOutCubic,
                            ),
                          ),
                          child: ListView.builder(
                            itemCount: state.todos.length,
                            itemBuilder: (context, index) {
                              final todo = state.todos[index];

                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 36,
                                  vertical: 12,
                                ),
                                elevation: 4,
                                child: ListTile(
                                  title: Text(
                                    todo.title.toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    todo.task,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: MaterialButton(
                                    height: 32,
                                    minWidth: 32,
                                    padding: const EdgeInsets.all(0),
                                    color: todo.completed
                                        ? AppTheme.accentColor
                                        : Colors.grey,
                                    shape: const CircleBorder(),
                                    onPressed: () =>
                                        context.read<TodoBloc>().add(
                                              TodoUpdated(
                                                todo: todo.copyWith(
                                                  completed: !todo.completed,
                                                ),
                                              ),
                                            ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (_) => BlocProvider.value(
                                        value: context.read<TodoBloc>(),
                                        child: TodoDetailsModalBottomSheet(
                                          todo: todo,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        context.read<TodoBloc>().add(TodoStarted()),
                    icon: const Icon(Icons.replay),
                    label: const Text('Retry'),
                  ),
                );
              }
            },
          ),
        ),
      );
}
