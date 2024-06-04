import 'package:flutter/material.dart';
import '../utils/favorite_manager.dart';
import './song_profile.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/left_side_panel.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
          if (!isMobile) const LeftSidePanel(selectedPage: 'favorite'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PlaylistDetailPage(
                playlistTitle: 'Therapy',
                onBack: () {},
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


class PlaylistDetailPage extends StatelessWidget {
  final String playlistTitle;
  final VoidCallback onBack;

  const PlaylistDetailPage({Key? key, required this.playlistTitle, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> playlistSongs = UserFavoriteManager.getFavorites().value;

    return Column(
      children: [
        if (playlistTitle != 'Therapy')
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: onBack,
              ),
              SizedBox(width: 16.0),
              Text(
                playlistTitle,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        Expanded(
          child: ListView.builder(
            itemCount: playlistSongs.length,
            itemBuilder: (context, index) {
              final song = playlistSongs[index];
              bool isFavorite = UserFavoriteManager.isFavorite(song['title']!);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  color: Colors.grey[900],
                  child: Row(
                    children: [
                      Image.asset(
                        song['image']!,
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(song['title']!, style: TextStyle(color: Colors.white)),
                          trailing: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: IconButton(
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.white,
                              ),
                              onPressed: () {
                                UserFavoriteManager.toggleFavorite(song['title']!, song['image']!);
                              },
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SongProfile(
                                  title: song['title']!,
                                  image: song['image']!,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

