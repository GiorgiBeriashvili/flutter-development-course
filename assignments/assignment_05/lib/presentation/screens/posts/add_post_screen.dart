import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  static const routeName = '/posts/add';

  final int userId;

  const AddPostScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                initialValue: widget.userId.toString(),
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.tag),
                                  labelText: 'User ID',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                readOnly: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                controller: titleController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.title),
                                  labelText: 'Title',
                                  hintText: 'Enter the title',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please provide a valid title'
                                        : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                controller: bodyController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.description),
                                  labelText: 'Body',
                                  hintText: 'Enter the body',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                minLines: 1,
                                maxLines: 10,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please provide a valid body'
                                        : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Back'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pop<Map<String, dynamic>>(
                                context,
                                {
                                  'userId': widget.userId,
                                  'title': titleController.text,
                                  'body': bodyController.text,
                                },
                              );
                            }
                          },
                          child: const Text('Create'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();

    super.dispose();
  }
}
