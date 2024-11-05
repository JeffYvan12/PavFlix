import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller with the intro video
    _controller = VideoPlayerController.asset("assets/pavflix_intro.mp4")
      ..initialize().then((_) {
        setState(() {}); // Update the state to refresh the UI
        _controller.play(); // Auto-play the video
      });

    // Add listener to check when the video finishes playing
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        _navigateToHome();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Navigate to the home screen
  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(
                color: Colors.redAccent,
              ),
      ),
    );
  }
}
