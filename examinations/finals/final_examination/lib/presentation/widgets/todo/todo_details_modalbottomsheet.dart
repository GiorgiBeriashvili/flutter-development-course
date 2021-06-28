import 'dart:ui';

import 'package:final_examination/core/theme.dart';
import 'package:final_examination/logic/blocs/todo_bloc.dart';
import 'package:final_examination/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:final_examination/data/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoDetailsModalBottomSheet extends StatefulWidget {
  final Todo todo;

  const TodoDetailsModalBottomSheet({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  _TodoDetailsModalBottomSheetState createState() =>
      _TodoDetailsModalBottomSheetState();
}

class _TodoDetailsModalBottomSheetState
    extends State<TodoDetailsModalBottomSheet> {
  late bool completed;

  @override
  void initState() {
    completed = widget.todo.completed;

    super.initState();
  }

  @override
  Widget build(BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4,
          sigmaY: 4,
        ),
        child: Container(
          color: AppTheme.primaryColorDark,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 8,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  child: ListView(
                    children: [
                      Text(
                        widget.todo.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        widget.todo.task,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        'TODO DESCRIPTION',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      Text(
                        widget.todo.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        color: completed
                            ? AppTheme.accentColor
                            : AppTheme.primaryColorLight,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8,
                            ),
                          ),
                        ),
                        onPressed: () => setState(() => completed = !completed),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'DONE',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      MaterialButton(
                        color: AppTheme.primaryColorLight,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8,
                            ),
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<TodoBloc>(),
                              child: TodoEditModalBottomSheet(
                                todo: widget.todo.copyWith(
                                  completed: completed,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'EDIT',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      MaterialButton(
                        color: AppTheme.primaryColorLight,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8,
                            ),
                          ),
                        ),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => BlocProvider.value(
                            value: context.read<TodoBloc>(),
                            child: AlertDialog(
                              title: const Text('Delete'),
                              content: Text(
                                'Would you like to delete "${widget.todo.title}"?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                    context.read<TodoBloc>().add(
                                          TodoDeleted(
                                            todo: widget.todo,
                                          ),
                                        );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '"${widget.todo.title}" has been deleted.',
                                        ),
                                        backgroundColor: AppTheme.accentColor,
                                      ),
                                    );
                                  },
                                  child: const Text('Confirm'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'DELETE',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 32,
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.backgroundColor,
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);

                          if (completed != widget.todo.completed) {
                            context.read<TodoBloc>().add(
                                  TodoUpdated(
                                    todo: widget.todo.copyWith(
                                      completed: completed,
                                    ),
                                  ),
                                );
                          }
                        },
                        child: const Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
