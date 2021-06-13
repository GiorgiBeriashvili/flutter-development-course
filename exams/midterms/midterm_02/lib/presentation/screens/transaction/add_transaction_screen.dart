import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddTransactionScreen extends StatefulWidget {
  static const routeName = '/transactions/add';

  const AddTransactionScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Create Transaction'),
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
                                keyboardType: TextInputType.name,
                                controller: titleController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.title),
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
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                  signed: true,
                                ),
                                controller: amountController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.attach_money),
                                  labelText: 'Amount',
                                  hintText: 'Enter the amount',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                textInputAction: TextInputAction.next,
                                validator: (value) => value == null ||
                                        value.isEmpty ||
                                        double.tryParse(value) == null
                                    ? 'Please provide a valid amount'
                                    : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                controller: descriptionController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.description),
                                  labelText: 'Description',
                                  hintText: 'Enter the description',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                minLines: 1,
                                maxLines: 10,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please provide a valid description'
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
                              Navigator.pop<Map<String, Object>>(
                                context,
                                {
                                  'id': const Uuid().v1().toString(),
                                  'title': titleController.text,
                                  'amount': double.parse(amountController.text),
                                  'description': descriptionController.text,
                                  'datetime': DateTime.now().toIso8601String(),
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
    amountController.dispose();
    descriptionController.dispose();

    super.dispose();
  }
}
