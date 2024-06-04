import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/favorite_songs_page.dart';
import '../pages/playlists_page.dart';
import '../pages/favorite_songs_page.dart';

class LeftSidePanel extends StatelessWidget {
  final String selectedPage;
  const LeftSidePanel({Key? key, required this.selectedPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildNavItem(context, Icons.home, 'Home', '/home', selectedPage == 'home'),
          _buildNavItem(context, Icons.library_music, 'Your Library', '/library', selectedPage == 'library'),
          _buildNavItem(context, Icons.search, 'Search', '/search', selectedPage == 'search'),
          _buildNavItem(context, Icons.favorite, 'Liked Songs', '/favorite', selectedPage == 'favorite'),
          _buildNavItem(context, Icons.playlist_play, 'Playlists', '/playlists', selectedPage == 'playlists'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route, bool isSelected) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.green : Colors.white),
      title: Text(title, style: TextStyle(color: isSelected ? Colors.green : Colors.white)),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}