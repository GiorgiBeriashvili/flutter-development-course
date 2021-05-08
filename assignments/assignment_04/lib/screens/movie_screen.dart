import 'package:flutter/material.dart';
import 'package:assignment_04/constants.dart' as constants;
import 'package:assignment_04/models/models.dart';

import 'package:assignment_04/repositories/repositories.dart';
import 'package:assignment_04/screens/screens.dart';
import 'package:assignment_04/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatelessWidget {
  static const routeName = '/';

  const MoviesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(constants.appTitle),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                TextButton(
                  onPressed: () => context.read<MovieRepository>().filterAll(),
                  child: Text('All'),
                ),
                Divider(),
                TextButton(
                  onPressed: () =>
                      context.read<MovieRepository>().filterRecentlyAdded(),
                  child: Text('Recently Added'),
                ),
                Divider(),
                TextButton(
                  onPressed: () =>
                      context.read<MovieRepository>().filterFavorites(),
                  child: Text('Favorite'),
                ),
              ],
            ),
          ),
        ),
        body: Consumer<MovieRepository>(
          builder: (context, value, child) {
            final movies = value.fetch();

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  MoviesDetailsScreen.routeName,
                  arguments: MoviesDetailsScreenArguments(
                    movie: movies[index],
                  ),
                ),
                onLongPress: () => Navigator.pushNamed(
                  context,
                  MoviesEditScreen.routeName,
                  arguments: MoviesEditScreenArguments(
                    index: index,
                    movie: movies[index],
                  ),
                ),
                child: MovieItem(
                  movie: movies[index],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(
            context,
            MoviesAddScreen.routeName,
          ),
        ),
      );
}
