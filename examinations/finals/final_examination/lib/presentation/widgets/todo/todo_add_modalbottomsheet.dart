import 'dart:ui';

import 'package:final_examination/core/theme.dart';
import 'package:final_examination/logic/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class TodoAddModalBottomSheet extends StatefulWidget {
  const TodoAddModalBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  _AddTodoModalBottomSheetState createState() =>
      _AddTodoModalBottomSheetState();
}

class _AddTodoModalBottomSheetState extends State<TodoAddModalBottomSheet> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final taskController = TextEditingController();
  final descriptionController = TextEditingController();

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
                      textAlign: TextAlign.center,
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
                      textAlign: TextAlign.center,
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
                      textAlign: TextAlign.center,
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
                      alignment: Alignment.topRight,
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
                                'id': const Uuid().v1().toString(),
                                'title': titleController.text,
                                'task': taskController.text,
                                'description': descriptionController.text,
                                'completed': false,
                              };

                              context.read<TodoBloc>().add(
                                    TodoCreated(
                                      todo: todo,
                                    ),
                                  );

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '"${todo['title']}" has been added.',
                                  ),
                                  backgroundColor: AppTheme.accentColor,
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
        ),
      );
}
