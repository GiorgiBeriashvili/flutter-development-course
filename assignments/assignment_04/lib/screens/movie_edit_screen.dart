import 'package:flutter/material.dart';
import 'package:assignment_04/models/models.dart';
import 'package:assignment_04/repositories/repositories.dart';
import 'package:provider/provider.dart';

class MoviesEditScreen extends StatefulWidget {
  static const routeName = '/edit';

  @override
  _MoviesEditScreenState createState() => _MoviesEditScreenState();
}

class _MoviesEditScreenState extends State<MoviesEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _imageUrlController;
  late TextEditingController _descriptionController;
  late TextEditingController _ratingController;
  late TextEditingController _categoryController;
  late TextEditingController _releaseYearController;

  @override
  Widget build(BuildContext context) {
    final movieRepository = context.read<MovieRepository>();

    final arguments =
        ModalRoute.of(context)!.settings.arguments as MoviesEditScreenArguments;

    final index = arguments.index;
    final movie = arguments.movie;

    _titleController = TextEditingController(text: movie.title);
    _imageUrlController = TextEditingController(text: movie.imageUrl);
    _descriptionController = TextEditingController(text: movie.description);
    _ratingController = TextEditingController(text: movie.rating.toString());
    _categoryController = TextEditingController(text: movie.category);
    _releaseYearController = TextEditingController(
      text: movie.releaseYear.toString(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Movie'),
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
                              initialValue: movie.id.toString(),
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
                                decimal: false,
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
                                icon: Icon(Icons.monetization_on),
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
                            movieRepository.update(
                              index,
                              Movie(
                                id: movie.id,
                                title: _titleController.text,
                                imageUrl: _imageUrlController.text,
                                description: _descriptionController.text,
                                rating: double.parse(_ratingController.text),
                                category: _categoryController.text,
                                releaseYear:
                                    int.parse(_releaseYearController.text),
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
    _titleController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    _ratingController.dispose();
    _categoryController.dispose();
    _releaseYearController.dispose();

    super.dispose();
  }
}
