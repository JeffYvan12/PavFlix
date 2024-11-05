import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'widgets/netflix_app_bar.dart';
import 'screens/auth/register_screen.dart';

void main() {
  runApp(PavFlixApp());
}

class PavFlixApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PavFlix',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen (),
      debugShowCheckedModeBanner: false,
    );
  }
}
