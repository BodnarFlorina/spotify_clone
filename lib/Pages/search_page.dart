import 'package:flutter/material.dart';
import '../utils/favorite_manager.dart';
import './song_profile.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/left_side_panel.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    UserFavoriteManager.getFavorites().addListener(_onFavoritesChanged);
  }

  @override
  void dispose() {
    UserFavoriteManager.getFavorites().removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _onFavoritesChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width <= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify Clone'),
        backgroundColor: Colors.black,
      ),
      body: Row(
        children: [
          if (!isMobile) const LeftSidePanel(selectedPage: 'search'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isMobile ? 2 : 3,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 2.0,
                      ),
                      itemCount: cardData.length,
                      itemBuilder: (context, index) {
                        final card = cardData[index];
                        return ColorfulCard(
                          title: card['title'],
                          color: card['color'],
                          icon: card['icon'],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isMobile ? const BottomNavBar() : null,
      backgroundColor: Colors.black,
    );
  }
}

class ColorfulCard extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;

  const ColorfulCard({
    Key? key,
    required this.title,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 45.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> cardData = [
  {'title': 'Rock', 'color': Colors.red, 'icon': Icons.music_note},
  {'title': 'Pop', 'color': Colors.blue, 'icon': Icons.headset},
  {'title': 'Jazz', 'color': Colors.green, 'icon': Icons.surround_sound},
  {'title': 'Hip Hop', 'color': Colors.orange, 'icon': Icons.audiotrack},
  {'title': 'Classical', 'color': Colors.purple, 'icon': Icons.library_music},
  {'title': 'Electronic', 'color': Colors.yellow, 'icon': Icons.equalizer},
  {'title': 'Reggae', 'color': Colors.brown, 'icon': Icons.queue_music},
  {'title': 'Country', 'color': Colors.teal, 'icon': Icons.album},
  {'title': 'Blues', 'color': Colors.indigo, 'icon': Icons.music_video},
];
