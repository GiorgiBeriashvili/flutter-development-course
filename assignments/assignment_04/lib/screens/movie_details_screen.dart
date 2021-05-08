import 'package:flutter/material.dart';
import 'package:assignment_04/models/models.dart';
import 'package:assignment_04/repositories/repositories.dart';
import 'package:provider/provider.dart';

class MoviesDetailsScreen extends StatelessWidget {
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments
        as MoviesDetailsScreenArguments;

    final movie = arguments.movie;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Remove Movie'),
                content: Text('Would you like to remove the movie?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final movieRepository = context.read<MovieRepository>();

                      movieRepository.remove(movie.id);

                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Remove'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/movie_placeholder.jpg',
                image: movie.imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 1.5,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title: '),
                    Text('Rating: '),
                    Text('Release Year: '),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      movie.rating.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      movie.releaseYear.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Text(
                        movie.description,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
