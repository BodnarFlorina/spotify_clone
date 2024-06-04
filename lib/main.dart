import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'Pages/favorite_songs_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/favorite_manager.dart';
import './Pages/favorite_page.dart';
import './Pages/playlists_page.dart';
import './Pages/search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getString('username') != null && prefs.getString('password') != null;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Clone',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: isLoggedIn ? HomePage() : LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/library': (context) => MyLibraryPage(),
        '/favorite': (context) => FavoritePage(),
        '/playlists': (context) => PlaylistsPage(),
        '/search': (context) => SearchPage(),
      },
    );
  }
}