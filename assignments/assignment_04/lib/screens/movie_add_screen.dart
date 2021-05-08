import 'package:flutter/material.dart';
import 'package:assignment_04/models/models.dart';
import 'package:assignment_04/repositories/repositories.dart';
import 'package:provider/provider.dart';

class MoviesAddScreen extends StatefulWidget {
  static const routeName = '/add';

  @override
  _MoviesAddScreenState createState() => _MoviesAddScreenState();
}

class _MoviesAddScreenState extends State<MoviesAddScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ratingController = TextEditingController();
  final _categoryController = TextEditingController();
  final _releaseYearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final movieRepository = context.read<MovieRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Movie'),
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
                              initialValue: movieRepository.id.toString(),
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
                              controller: _titleController,
                              decoration: InputDecoration(
                                icon: Icon(Icons.title),
                                labelText: 'Title',
                                hintText: 'Enter Title',
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
                              keyboardType: TextInputType.url,
                              controller: _imageUrlController,
                              decoration: InputDecoration(
                                icon: Icon(Icons.image),
                                labelText: 'Image',
                                hintText: 'Enter Image',
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
                              keyboardType: TextInputType.multiline,
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                icon: Icon(Icons.description),
                                labelText: 'Description',
                                hintText: 'Enter Description',
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              keyboardType: TextInputType.numberWithOptions(
                                signed: false,
                                decimal: true,
                              ),
                              controller: _ratingController,
                              decoration: InputDecoration(
                                icon: Icon(Icons.star),
                                labelText: 'Rating',
                                hintText: 'Enter Rating',
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (value) => value == null ||
                                      value.isEmpty ||
                                      double.tryParse(value) == null ||
                                      double.parse(value) < 0
                                  ? 'Please provide a valid rating'
                                  : null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _categoryController,
                              decoration: InputDecoration(
                                icon: Icon(Icons.category),
                                labelText: 'Category',
                                hintText: 'Enter Category',
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (value) => value == null ||
                                      value.isEmpty ||
                                      (value != 'Recently Added' &&
                                          value != 'Favorite')
                                  ? 'Please provide a valid category'
                                  : null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _releaseYearController,
                              decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                labelText: 'Release Year',
                                hintText: 'Enter Release Year',
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (value) => value == null ||
                                      value.isEmpty ||
                                      int.tryParse(value) == null ||
                                      int.parse(value) < 0
                                  ? 'Please provide a valid year'
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
                            movieRepository.add(
                              Movie(
                                id: movieRepository.id + 1,
                                title: _titleController.text,
                                imageUrl: _imageUrlController.text,
                                description: _descriptionController.text,
                                rating: double.parse(_ratingController.text),
                                category: _categoryController.text,
                                releaseYear:
                                    int.parse(_releaseYearController.text),
                              ),
                            );

                            movieRepository.id++;

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
  }

  @override
  void dispose() {
    _titleController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    _ratingController.dispose();
    _categoryController.dispose();
    _releaseYearController.dispose();

    super.dispose();
  }
}
