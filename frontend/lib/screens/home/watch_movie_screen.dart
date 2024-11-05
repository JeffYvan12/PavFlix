import 'package:flutter/material.dart';
import '../../models/movie.dart';

class WatchMovieScreen extends StatelessWidget {
  final Movie movie;

  WatchMovieScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(movie.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Now Watching: ${movie.title}",
              style: TextStyle(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Icon(
              Icons.play_circle_fill,
              color: Colors.red,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              movie.overview,
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
