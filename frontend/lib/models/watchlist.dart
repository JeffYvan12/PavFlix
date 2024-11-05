import 'movie.dart';
class Watchlist {
  final String id;
  final String name;
  final List<Movie> movies;

  Watchlist({
    required this.id,
    required this.name,
    required this.movies,
  });

  factory Watchlist.fromJson(Map<String, dynamic> json) {
    return Watchlist(
      id: json['_id'],
      name: json['name'],
      movies: (json['movies'] as List)
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList(),
    );
  }
}
