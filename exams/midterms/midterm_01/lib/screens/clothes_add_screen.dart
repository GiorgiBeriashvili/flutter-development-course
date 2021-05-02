import 'package:flutter/material.dart';
import 'package:midterm_01/models/models.dart';
import 'package:midterm_01/repositories/repositories.dart';

class ClothesAddScreen extends StatefulWidget {
  static const routeName = '/add';

  @override
  _ClothesAddScreenState createState() => _ClothesAddScreenState();
}

class _ClothesAddScreenState extends State<ClothesAddScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _sizeController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _clothesRepository = ClothesRepository();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Add Clothes'),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
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
                                initialValue: ClothesRepository.id.toString(),
                                decoration: InputDecoration(
                                  icon: Icon(Icons.tag),
                                  labelText: 'ID',
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
                                controller: _nameController,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.title),
                                  labelText: 'Name',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please provide a valid name'
                                        : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.url,
                                controller: _imageUrlController,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.image),
                                  labelText: 'Image',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                textInputAction: TextInputAction.next,
                                validator: (value) => value == null ||
                                        value.isEmpty ||
                                        !RegExp(r'(?:([^:/?#]+):)?(?://([^/?#]*))?([^?#]*\.(?:jpg|gif|png))(?:\?([^#]*))?(?:#(.*))?')
                                            .hasMatch(value)
                                    ? 'Please provide a valid image'
                                    : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _sizeController,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.square_foot),
                                  labelText: 'Size',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please provide a valid size'
                                        : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: true,
                                ),
                                controller: _priceController,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.monetization_on),
                                  labelText: 'Price',
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                                textInputAction: TextInputAction.next,
                                validator: (value) => value == null ||
                                        value.isEmpty ||
                                        double.tryParse(value) == null ||
                                        double.parse(value) < 0
                                    ? 'Please provide a valid price'
                                    : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                controller: _descriptionController,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.description),
                                  labelText: 'Description',
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
                          child: Text('Back'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _clothesRepository.add(
                                Clothes(
                                  id: ClothesRepository.id,
                                  name: _nameController.text,
                                  imageUrl: _imageUrlController.text,
                                  size: _sizeController.text,
                                  price: double.parse(_priceController.text),
                                  description: _descriptionController.text,
                                ),
                              );

                              ClothesRepository.id++;

                              Navigator.pop(context);
                            }
                          },
                          child: Text('Add'),
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
    _nameController.dispose();
    _imageUrlController.dispose();
    _sizeController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }
}
