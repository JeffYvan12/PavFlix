class Movie {
  final String id;
  final String title;
  final String genre;
  final String director;
  final double rating;
  final String releaseDate;
  final String overview;
  final String posterPath;

  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.director,
    required this.rating,
    required this.releaseDate,
    required this.overview,
    required this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'],
      title: json['title'],
      genre: json['genre'],
      director: json['director'],
      rating: json['rating'].toDouble(),
      releaseDate: json['release_date'],
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }
}
