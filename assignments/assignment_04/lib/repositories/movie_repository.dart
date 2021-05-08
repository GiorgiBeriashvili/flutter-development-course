import 'package:assignment_04/models/models.dart';
import 'package:flutter/foundation.dart';

class MovieRepository extends ChangeNotifier {
  List<Movie> _movies = [
    Movie(
      id: 1,
      title: "Inception",
      imageUrl:
          "https://c8.alamy.com/comp/RYHBXJ/movie-poster-inception-2010-RYHBXJ.jpg",
      description:
          "A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.",
      rating: 8.8,
      category: "Recently Added",
      releaseYear: 2010,
    ),
    Movie(
      id: 2,
      title: "The Shawshank Redemption",
      imageUrl:
          "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UY1200_CR89,0,630,1200_AL_.jpg",
      description:
          "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.",
      rating: 9.3,
      category: "Recently Added",
      releaseYear: 1994,
    ),
    Movie(
      id: 3,
      title: "The Prestige",
      imageUrl:
          "https://m.media-amazon.com/images/M/MV5BMjA4NDI0MTIxNF5BMl5BanBnXkFtZTYwNTM0MzY2._V1_.jpg",
      description:
          "After a tragic accident, two stage magicians engage in a battle to create the ultimate illusion while sacrificing everything they have to outwit each other.",
      rating: 8.5,
      category: "Recently Added",
      releaseYear: 2006,
    ),
    Movie(
      id: 4,
      title: "The Dark Knight Rises",
      imageUrl:
          "https://1.bp.blogspot.com/-OoV0-JjdT1Q/UA1W5Dax8sI/AAAAAAAAD2Q/XAm_PccAiNw/s1600/the-dark-knight-rises-tom-hardy-poster1.jpg",
      description:
          "Eight years after the Joker's reign of anarchy, Batman, with the help of the enigmatic Catwoman, is forced from his exile to save Gotham City from the brutal guerrilla terrorist Bane.",
      rating: 8.4,
      category: "Recently Added",
      releaseYear: 2012,
    ),
    Movie(
      id: 5,
      title: "The Dark Knight",
      imageUrl:
          "https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_.jpg",
      description:
          "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      rating: 9.0,
      category: "Recently Added",
      releaseYear: 2008,
    ),
    Movie(
      id: 6,
      title: "Fight Club",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/en/f/fc/Fight_Club_poster.jpg",
      description:
          "An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.",
      rating: 8.8,
      category: "Recently Added",
      releaseYear: 1993,
    ),
    Movie(
      id: 7,
      title: "Zack Snyder's Justice League",
      imageUrl:
          "https://images-na.ssl-images-amazon.com/images/S/pv-target-images/63cc50980f30d8d8982e165c2e856a7c5d9ec8be4b3af222525f18f315f19694._RI_V_TTW_.jpg",
      description:
          "Zack Snyder's definitive director's cut of Justice League. Determined to ensure Superman's ultimate sacrifice was not in vain, Bruce Wayne aligns forces with Diana Prince with plans to recruit a team of metahumans to protect the world from an approaching threat of catastrophic proportions.",
      rating: 8.5,
      category: "Favorite",
      releaseYear: 2021,
    ),
    Movie(
      id: 8,
      title: "WandaVision",
      imageUrl:
          "https://m.media-amazon.com/images/M/MV5BYjJiZmE5ZDgtYWUxZi00MWI1LTg2MmEtZmUwZGE2YzRkNTE5XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg",
      description:
          "Blends the style of classic sitcoms with the MCU, in which Wanda Maximoff and Vision - two super-powered beings living their ideal suburban lives - begin to suspect that everything is not as it seems.",
      rating: 8.2,
      category: "Favorite",
      releaseYear: 2021,
    ),
    Movie(
      id: 9,
      title: "Avengers: Endgame",
      imageUrl:
          "https://live.staticflickr.com/65535/49460296257_31e8216abb_b.jpg",
      description:
          "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe.",
      rating: 8.4,
      category: "Favorite",
      releaseYear: 2019,
    ),
    Movie(
      id: 10,
      title: "Soul",
      imageUrl: "https://i.ytimg.com/vi/EVB21AxR1Hw/movieposter_en.jpg",
      description:
          "After landing the gig of a lifetime, a New York jazz pianist suddenly finds himself trapped in a strange land between Earth and the afterlife.",
      rating: 8.1,
      category: "Favorite",
      releaseYear: 2020,
    ),
    Movie(
      id: 11,
      title: "The Queen's Gambit",
      imageUrl:
          "https://live.staticflickr.com/65535/50673553037_9f0f60709a_b.jpg",
      description:
          "Orphaned at the tender age of nine, prodigious introvert Beth Harmon discovers and masters the game of chess in 1960s USA. But child stardom comes at a price.",
      rating: 8.6,
      category: "Favorite",
      releaseYear: 2020,
    ),
  ];

  late int id;
  late List<Movie> filteredMovies;

  MovieRepository() {
    filteredMovies = List.from(_movies);
    id = _movies.last.id + 1;
  }

  void add(Movie movie) {
    _movies.add(movie);

    if (filteredMovies.length == _movies.length - 1 ||
        filteredMovies.first.category == movie.category) {
      filteredMovies.add(movie);
    }

    notifyListeners();
  }

  List<Movie> fetch() => filteredMovies;

  void remove(int id) {
    filteredMovies.removeWhere((movie) => movie.id == id);
    _movies.removeWhere((movie) => movie.id == id);

    notifyListeners();
  }

  void update(int index, Movie movie) {
    if (movie.category != filteredMovies[index].category) {
      filteredMovies.removeAt(index);
    } else {
      filteredMovies[index] = movie;
    }

    _movies[_movies.indexOf(
      _movies.firstWhere((origin) => origin.id == movie.id),
    )] = movie;

    notifyListeners();
  }

  void filterAll() {
    filteredMovies = _movies;

    notifyListeners();
  }

  void filterRecentlyAdded() {
    filteredMovies =
        _movies.where((movie) => movie.category == "Recently Added").toList();

    notifyListeners();
  }

  void filterFavorites() {
    filteredMovies =
        _movies.where((movie) => movie.category == "Favorite").toList();

    notifyListeners();
  }
}
