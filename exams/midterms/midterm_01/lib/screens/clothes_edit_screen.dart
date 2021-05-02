import 'package:flutter/material.dart';
import 'package:midterm_01/models/models.dart';
import 'package:midterm_01/repositories/repositories.dart';

class ClothesEditScreen extends StatefulWidget {
  static const routeName = '/edit';

  @override
  _ClothesEditScreenState createState() => _ClothesEditScreenState();
}

class _ClothesEditScreenState extends State<ClothesEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _imageUrlController;
  late TextEditingController _sizeController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  final _clothesRepository = ClothesRepository();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments
        as ClothesEditScreenArguments;

    final index = arguments.index;
    final clothes = arguments.clothes;

    _nameController = TextEditingController(text: clothes.name);
    _imageUrlController = TextEditingController(text: clothes.imageUrl);
    _sizeController = TextEditingController(text: clothes.size);
    _priceController = TextEditingController(text: clothes.price.toString());
    _descriptionController = TextEditingController(text: clothes.description);

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Clothes'),
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
                              initialValue: clothes.id.toString(),
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
                            _clothesRepository.update(
                              index,
                              Clothes(
                                id: clothes.id,
                                name: _nameController.text,
                                imageUrl: _imageUrlController.text,
                                size: _sizeController.text,
                                price: double.parse(_priceController.text),
                                description: _descriptionController.text,
                              ),
                            );

                            Navigator.pop(context);
                          }
                        },
                        child: Text('Update'),
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
  }

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
