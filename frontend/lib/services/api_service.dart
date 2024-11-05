import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';
import '../models/watchlist.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000/api';

  // Login method to get a token
  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      return token;
    }
    return null;
  }

  // Register new user
  Future<String?> register(String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'email': email, 'password': password}),
    );
    if (response.statusCode == 201) {
      return "User registered successfully!";
    }
    return null;
  }

  // Get all movies
  Future<List<Movie>> getAllMovies() async {
    final url = Uri.parse('$baseUrl/movies');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> moviesJson = jsonDecode(response.body);
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    }
    throw Exception('Failed to load movies');
  }

  // Add a new movie to the database
  Future<void> addMovie(String title, String genre, String director, double rating,
      String releaseDate, String overview) async {
    final url = Uri.parse('$baseUrl/movies');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'genre': genre,
        'director': director,
        'rating': rating,
        'release_date': releaseDate,
        'overview': overview,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add movie');
    }
  }

  // Create a new watchlist for the user
  Future<void> createWatchlist(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('$baseUrl/watchlist');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create watchlist');
    }
  }

  // Get all watchlists for the user
  Future<List<Watchlist>> getUserWatchlists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('$baseUrl/watchlist');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      List<dynamic> watchlistsJson = jsonDecode(response.body);
      return watchlistsJson.map((json) => Watchlist.fromJson(json)).toList();
    }
    throw Exception('Failed to load watchlists');
  }

  // Add a movie to an existing watchlist
  Future<void> addToWatchlist(String watchlistId, String movieId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final url = Uri.parse('$baseUrl/watchlist/$watchlistId/movies');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'movieId': movieId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add movie to watchlist');
    }
  }
}
