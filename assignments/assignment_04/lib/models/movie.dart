class Movie {
  final int id;
  final String title;
  final String imageUrl;
  final String description;
  final double rating;
  final String category;
  final int releaseYear;

  const Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.category,
    required this.releaseYear,
  });
}

class MoviesDetailsScreenArguments {
  final Movie movie;

  const MoviesDetailsScreenArguments({
    required this.movie,
  });
}

class MoviesEditScreenArguments {
  final int index;
  final Movie movie;

  const MoviesEditScreenArguments({
    required this.index,
    required this.movie,
  });
}
