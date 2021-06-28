import 'dart:ui';

import 'package:final_examination/core/theme.dart';
import 'package:final_examination/data/models/todo.dart';
import 'package:final_examination/logic/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoEditModalBottomSheet extends StatefulWidget {
  final Todo todo;

  const TodoEditModalBottomSheet({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  _EditTodoModalBottomSheetState createState() =>
      _EditTodoModalBottomSheetState();
}

class _EditTodoModalBottomSheetState extends State<TodoEditModalBottomSheet> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final TextEditingController taskController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.todo.title);
    taskController = TextEditingController(text: widget.todo.task);
    descriptionController = TextEditingController(
      text: widget.todo.description,
    );

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    taskController.dispose();
    descriptionController.dispose();

    super.dispose();
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
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      controller: titleController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.primaryColorLight,
                          ),
                        ),
                        hintText: 'Please enter title',
                        hintStyle: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please provide a valid title'
                          : null,
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      controller: taskController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.primaryColorLight,
                          ),
                        ),
                        hintText: 'Please enter task',
                        hintStyle: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please provide a valid task'
                          : null,
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: TextFormField(
                      textAlign: TextAlign.left,
                      controller: descriptionController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.primaryColorLight,
                          ),
                        ),
                        hintText: 'Please enter task details',
                        hintStyle: TextStyle(
                          color: Colors.white60,
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 10,
                      textInputAction: TextInputAction.next,
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please provide valid task details'
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 28,
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
                            if (formKey.currentState!.validate()) {
                              final todo = {
                                'id': widget.todo.id,
                                'title': titleController.text,
                                'task': taskController.text,
                                'description': descriptionController.text,
                                'completed': widget.todo.completed,
                              };

                              context.read<TodoBloc>().add(
                                    TodoUpdated(
                                      todo: Todo.fromJson(
                                        todo,
                                      ),
                                    ),
                                  );

                              Navigator.pop(context);
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '"${widget.todo.title}" has been edited.',
                                  ),
                                  backgroundColor: AppTheme.accentColor,
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'EDIT',
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
        ),
      );
}
