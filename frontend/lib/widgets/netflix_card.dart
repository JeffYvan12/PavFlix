import 'package:flutter/material.dart';
import '../models/movie.dart';

class NetflixCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  NetflixCard({required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: movie.posterPath.isNotEmpty
                  ? Image.network(
                      movie.posterPath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    )
                  : Container(
                      height: 200,
                      color: Colors.grey[800],
                      child: Icon(
                        Icons.movie,
                        color: Colors.grey[600],
                        size: 60,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Title
                  Text(
                    movie.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  // Movie Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "${movie.rating}/10",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
