import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: movie.posterPath.isNotEmpty
                ? Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    height: 200,
                    width: 150,
                  )
                : Container(
                    height: 200,
                    width: 150,
                    color: Colors.grey[800],
                    child: Icon(
                      Icons.movie,
                      color: Colors.grey[600],
                      size: 60,
                    ),
                  ),
          ),
          SizedBox(height: 8),
          // Movie Title
          Text(
            movie.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          // Movie Rating
          Text(
            "${movie.rating}/10",
            style: TextStyle(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
