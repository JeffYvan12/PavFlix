class Movie {
  final String id;
  final String title;
  final String genre;
  final String director;
  final double rating;
  final String releaseDate;
  final String overview;
  final String posterPath;
  final String posterUrl;  // This property holds the URL for the movie poster image

  Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.director,
    required this.rating,
    required this.releaseDate,
    required this.overview,
    required this.posterPath,
    required this.posterUrl,
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
      posterUrl: 'https://image.tmdb.org/t/p/w500' + json['poster_path'],  // Assuming the JSON has a 'poster_path' field
    );
  }
}
