import 'package:flutter/material.dart';
import '../utils/favorite_manager.dart';
import './song_profile.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/left_side_panel.dart';

class MyLibraryPage extends StatefulWidget {
  const MyLibraryPage({Key? key}) : super(key: key);

  @override
  _MyLibraryPageState createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage> {
  String? selectedPlaylist;

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
          if (!isMobile) const LeftSidePanel(selectedPage: 'library'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: selectedPlaylist == null
                  ? _LibraryContent(
                onPlaylistSelected: (playlist) {
                  setState(() {
                    selectedPlaylist = playlist;
                  });
                },
              )
                  : PlaylistDetailPage(
                playlistTitle: selectedPlaylist!,
                onBack: () {
                  setState(() {
                    selectedPlaylist = null;
                  });
                },
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

class _LibraryContent extends StatelessWidget {
  final void Function(String) onPlaylistSelected;

  const _LibraryContent({Key? key, required this.onPlaylistSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildPlaylistSection(
          context,
          'Liked Songs',
          [
            {'title': 'Therapy', 'image': 'assets/images/favorite.jpg'},
          ],
        ),
        _buildPlaylistSection(
          context,
          'Popular radio',
          [
            {'title': 'Daily Mix 3', 'image': 'assets/images/playlist1.jpg'},
            {'title': 'Hituri internationale 2024', 'image': 'assets/images/playlist2.jpg'},
            {'title': 'Rare', 'image': 'assets/images/playlist3.jpg'},
            {'title': 'Deep House 2024', 'image': 'assets/images/playlist4.jpg'},
            {'title': 'Please Don t be', 'image': 'assets/images/playlist5.jpg'},
          ],
        ),
        _buildPlaylistSection(
          context,
          'Relaxing Hits',
          [
            {'title': 'Acoustic Covers', 'image': 'assets/images/playlist9.jpg'},
            {'title': 'acoustic coffee club', 'image': 'assets/images/playlist6.jpg'},
            {'title': 'Weekend Mood', 'image': 'assets/images/playlist7.jpg'},
            {'title': 'Call It A Day', 'image': 'assets/images/playlist8.jpg'},
            {'title': 'Broken Heart', 'image': 'assets/images/playlist10.jpg'},
          ],
        ),
      ],
    );
  }

  Widget _buildPlaylistSection(BuildContext context, String sectionTitle, List<Map<String, String>> playlists) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: MediaQuery.of(context).size.width > 600 ? 250 : 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: HoverCard(
                      title: playlist['title']!,
                      image: playlist['image']!,
                      onTap: () {
                        onPlaylistSelected(playlist['title']!);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HoverCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const HoverCard({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaylistDetailPage extends StatelessWidget {
  final String playlistTitle;
  final VoidCallback onBack;

  const PlaylistDetailPage({Key? key, required this.playlistTitle, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playlists = {
      'Therapy': UserFavoriteManager.getFavorites().value,
      'Daily Mix 3': [
        {'title': 'Poem', 'image': 'assets/images/img1.jpg'},
        {'title': 'Doua inimi', 'image': 'assets/images/img2.jpg'},
        {'title': 'Infinit', 'image': 'assets/images/img3.jpg'},
        {'title': 'Pe bune', 'image': 'assets/images/img4.jpg'},
        {'title': 'Te rog', 'image': 'assets/images/img5.jpg'},
        {'title': 'Imperfect', 'image': 'assets/images/img6.jpg'},
        {'title': 'la rasarit', 'image': 'assets/images/img7.jpg'},
      ],
      'Hituri internationale 2024': [
        {'title': 'la rasarit', 'image': 'assets/images/img7.jpg'},
        {'title': 'Scara 2, etajul 7', 'image': 'assets/images/img8.jpg'},
        {'title': 'Învață să zbori', 'image': 'assets/images/img9.jpg'},
        {'title': 'Stelele nopții', 'image': 'assets/images/img10.jpg'},
        {'title': 'Liniștea serii', 'image': 'assets/images/img2.jpg'},
        {'title': 'Vis de vară', 'image': 'assets/images/img1.jpg'},
        {'title': 'Cântec de dor', 'image': 'assets/images/img3.jpg'},
        {'title': 'Întoarcerea acasă', 'image': 'assets/images/img4.jpg'},
        {'title': 'Umbre în soare', 'image': 'assets/images/img11.jpg'},
        {'title': 'Pasiunea mea', 'image': 'assets/images/img12.jpg'}
      ],
      'Rare': [
        {'title': 'Run', 'image': 'assets/images/music2.jpg'},
        {'title': 'Want u', 'image': 'assets/images/music2.jpg'},
        {'title': 'Ego', 'image': 'assets/images/music2.jpg'},
        {'title': 'Hold on me', 'image': 'assets/images/music2.jpg'},
        {'title': 'Ride with you', 'image': 'assets/images/music2.jpg'},
        {'title': 'No sense', 'image': 'assets/images/music2.jpg'},
        {'title': 'Dance All Night', 'image': 'assets/images/music2.jpg'},
        {'title': 'Feel the Beat', 'image': 'assets/images/music2.jpg'},
        {'title': 'Electric Dreams', 'image': 'assets/images/music2.jpg'},
      ],
      'Deep House 2024': [
        {'title': 'Heartbeat', 'image': 'assets/images/music2.jpg'},
        {'title': 'Neon Lights', 'image': 'assets/images/music2.jpg'},
        {'title': 'Midnight City', 'image': 'assets/images/music2.jpg'},
        {'title': 'Lost in Echoes', 'image': 'assets/images/music2.jpg'},
        {'title': 'Endless Journey', 'image': 'assets/images/music2.jpg'},
        {'title': 'Dreams of Tomorrow', 'image': 'assets/images/music2.jpg'},
        {'title': 'Echoes of You', 'image': 'assets/images/music2.jpg'},
        {'title': 'Waves of Time', 'image': 'assets/images/music2.jpg'},
        {'title': 'Silent Whisper', 'image': 'assets/images/music2.jpg'},
        {'title': 'Eternal Love', 'image': 'assets/images/music2.jpg'}
      ],
      'Please Don t be': [
        {'title': 'Neon Lights', 'image': 'assets/images/music2.jpg'},
        {'title': 'Midnight City', 'image': 'assets/images/music2.jpg'},
        {'title': 'Lost in Echoes', 'image': 'assets/images/music2.jpg'},
        {'title': 'Endless Journey', 'image': 'assets/images/music2.jpg'},
        {'title': 'Starry Night', 'image': 'assets/images/music2.jpg'},
        {'title': 'Moonlight Shadow', 'image': 'assets/images/music2.jpg'},
        {'title': 'City Lights', 'image': 'assets/images/music2.jpg'},
        {'title': 'Dream Chaser', 'image': 'assets/images/music2.jpg'},
        {'title': 'Rhythm of Life', 'image': 'assets/images/music2.jpg'}
      ],
      'Acoustic Covers': [
        {'title': 'Morning Dew', 'image': 'assets/images/music2.jpg'},
        {'title': 'Whispering Pines', 'image': 'assets/images/music2.jpg'},
        {'title': 'Gentle Breeze', 'image': 'assets/images/music2.jpg'},
        {'title': 'Sunset Melody', 'image': 'assets/images/music2.jpg'},
        {'title': 'Autumn Leaves', 'image': 'assets/images/music2.jpg'},
        {'title': 'Quiet Moments', 'image': 'assets/images/music2.jpg'},
        {'title': 'Evening Glow', 'image': 'assets/images/music2.jpg'},
        {'title': 'Heartstrings', 'image': 'assets/images/music2.jpg'}
      ],
      'acoustic coffee club': [
        {'title': 'Acoustic Dreams', 'image': 'assets/images/music2.jpg'},
        {'title': 'Unplugged Serenity', 'image': 'assets/images/music2.jpg'},
        {'title': 'Wooden Echoes', 'image': 'assets/images/music2.jpg'},
        {'title': 'String Serenade', 'image': 'assets/images/music2.jpg'},
        {'title': 'Campfire Tales', 'image': 'assets/images/music2.jpg'},
        {'title': 'Acoustic Bliss', 'image': 'assets/images/music2.jpg'},
        {'title': 'Rustic Harmonies', 'image': 'assets/images/music2.jpg'},
        {'title': 'Echoes Unplugged', 'image': 'assets/images/music2.jpg'}
      ],
      'Weekend Mood': [
        {'title': 'Acoustic Journey', 'image': 'assets/images/music2.jpg'},
        {'title': 'Silent Reflections', 'image': 'assets/images/music2.jpg'},
        {'title': 'Serenade of Strings', 'image': 'assets/images/music2.jpg'},
        {'title': 'Whispering Wind', 'image': 'assets/images/music2.jpg'},
        {'title': 'Mountain Echoes', 'image': 'assets/images/music2.jpg'},
        {'title': 'Sunrise Over the Hills', 'image': 'assets/images/music2.jpg'},
        {'title': 'Peaceful Pathways', 'image': 'assets/images/music2.jpg'},
        {'title': 'Timeless Moments', 'image': 'assets/images/music2.jpg'}
      ],
      'Call It A Day': [
        {'title': 'Acoustic Sunrise', 'image': 'assets/images/music2.jpg'},
        {'title': 'Barefoot Waltz', 'image': 'assets/images/music2.jpg'},
        {'title': 'Guitar Lullaby', 'image': 'assets/images/music2.jpg'},
        {'title': 'Campfire Melodies', 'image': 'assets/images/music2.jpg'},
        {'title': 'Purely Acoustic', 'image': 'assets/images/music2.jpg'},
        {'title': 'Simple Pleasures', 'image': 'assets/images/music2.jpg'},
        {'title': 'Rustic Romance', 'image': 'assets/images/music2.jpg'},
        {'title': 'Nature s Whisper', 'image': 'assets/images/music2.jpg'}
      ],
      'Broken Heart': [
        {'title': 'Tears in the Rain', 'image': 'assets/images/music2.jpg'},
        {'title': 'Lost Without You', 'image': 'assets/images/music2.jpg'},
        {'title': 'Heartache Melody', 'image': 'assets/images/music2.jpg'},
        {'title': 'Empty Promises', 'image': 'assets/images/music2.jpg'},
        {'title': 'Fading Memories', 'image': 'assets/images/music2.jpg'},
        {'title': 'Echoes of Goodbye', 'image': 'assets/images/music2.jpg'},
        {'title': 'Lonely Nights', 'image': 'assets/images/music2.jpg'},
        {'title': 'Broken Dreams', 'image': 'assets/images/music2.jpg'}
      ],
    };

    final playlistSongs = playlists[playlistTitle] ?? [];


    return Column(
      children: [
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
