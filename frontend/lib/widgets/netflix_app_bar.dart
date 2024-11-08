import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/add_movie_screen.dart';
import '../screens/home/add_watchlist_screen.dart';

class NetflixAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _NetflixAppBarState createState() => _NetflixAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(400);
}

class _NetflixAppBarState extends State<NetflixAppBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Key for controlling the Scaffold
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  bool _isDarkMode = true; // Start in Dark Mode

  final List<String> _movieImages = [
    'https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
    'https://image.tmdb.org/t/p/w500/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg',
    'https://image.tmdb.org/t/p/w500/xCEg6KowNISWvMh8GvPSxtdf9TO.jpg',
    'https://image.tmdb.org/t/p/w500/4q2hz2m8hubgvijz8Ez0T2Os2Yv.jpg'
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  // Start auto-scrolling the movie images every 5 seconds
  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < _movieImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // Toggle Dark Mode
  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double squareImageSize = MediaQuery.of(context).size.width * 0.45;
    final Color backgroundColor = _isDarkMode ? Colors.black : Colors.white;
    final Color textColor = _isDarkMode ? Colors.white : Colors.black;
    final Color buttonColor = _isDarkMode ? Colors.redAccent : Colors.black;

    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Pavflix', style: TextStyle(color: buttonColor)),
        actions: [
          // Menu Button at Top Right
          IconButton(
            icon: Icon(Icons.menu, color: buttonColor),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer(); // Open Drawer from the top right
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: backgroundColor, // Dynamic background color for Drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: buttonColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: textColor, fontSize: 24),
              ),
            ),
            // Settings Option
            ListTile(
              leading: Icon(Icons.settings, color: buttonColor),
              title: Text('Settings', style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings screen
              },
            ),
            // Dark Mode Toggle
            ListTile(
              leading: Icon(
                _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: buttonColor,
              ),
              title: Text('Dark Mode', style: TextStyle(color: textColor)),
              trailing: Switch(
                value: !_isDarkMode,
                onChanged: (value) => _toggleDarkMode(),
              ),
            ),
            // User Profile Option
            ListTile(
              leading: Icon(Icons.person, color: buttonColor),
              title: Text('User Profile', style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.pop(context);
                // Navigate to user profile screen
              },
            ),
            // Notifications Option
            ListTile(
              leading: Icon(Icons.notifications, color: buttonColor),
              title: Text('Notifications', style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.pop(context);
                // Navigate to notifications screen
              },
            ),
            // Help & Support Option
            ListTile(
              leading: Icon(Icons.help, color: buttonColor),
              title: Text('Help & Support', style: TextStyle(color: textColor)),
              onTap: () {
                Navigator.pop(context);
                // Navigate to help screen
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered Square Image Carousel
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              height: squareImageSize, // Square image size
              width: squareImageSize,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _movieImages.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      _movieImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            // Welcome Message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Text(
                    "Welcome to Pavflix",
                    style: TextStyle(
                      color: buttonColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Dive into endless worlds of movies, curated just for you.",
                    style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Discover, save, and share your favorite films anytime, anywhere, "
                    "with the ultimate streaming experience.",
                    style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Spacer(),
            // Bottom Navigation Buttons
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Home Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.home, color: buttonColor, size: 28),
                        SizedBox(height: 4),
                        Text("Home", style: TextStyle(color: buttonColor, fontSize: 14)),
                      ],
                    ),
                  ),
                  // Movies Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddMovieScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.movie, color: buttonColor, size: 28),
                        SizedBox(height: 4),
                        Text("Movies", style: TextStyle(color: buttonColor, fontSize: 14)),
                      ],
                    ),
                  ),
                  // Watchlist Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddWatchlistScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.bookmark, color: buttonColor, size: 28),
                        SizedBox(height: 4),
                        Text("Watchlist", style: TextStyle(color: buttonColor, fontSize: 14)),
                      ],
                    ),
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
