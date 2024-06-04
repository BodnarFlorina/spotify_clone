import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/left_side_panel.dart';
import 'song_profile.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify Clone'),
        backgroundColor: Colors.black,
      ),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 600)
            const LeftSidePanel(selectedPage: 'home'),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: HomeContent(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width <= 600
          ? const BottomNavBar()
          : null,
      backgroundColor: Colors.black,
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Frequent playlists',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        // Artisti
        LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 600;
            final imageSize = isWideScreen ? 50.0 : 40.0;
            final textSize = isWideScreen ? 18.0 : 14.0;

            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWideScreen ? 3 : 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 6.0,
                childAspectRatio: 4,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                final artists = [
                  {'name': 'Borden Hexam', 'image': 'assets/images/image1.jpg'},
                  {'name': 'Adiana Reese', 'image': 'assets/images/image2.jpg'},
                  {'name': 'Serena Howat', 'image': 'assets/images/image3.jpg'},
                  {'name': 'Natty Ginnaly', 'image': 'assets/images/image4.jpg'},
                  {'name': 'Tiebout Trivett', 'image': 'assets/images/image5.jpg'},
                  {'name': 'Marlie Thying', 'image': 'assets/images/image6.jpg'},
                ];
                final artist = artists[index];

                return ArtistCard(
                  name: artist['name']!,
                  image: artist['image']!,
                  imageSize: imageSize,
                  textSize: textSize,
                );
              },
            );
          },
        ),
        // Secțiunea "Popular Hits"
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Made for User',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 600;
            return SizedBox(
              height: isWideScreen ? 250 : 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6, (index) {
                    final popularHits = [
                      {'title': 'This Minimal Technology', 'image': 'assets/images/image7.jpg'},
                      {'title': 'Let It Go', 'image': 'assets/images/image8.jpg'},
                      {'title': 'Embrace', 'image': 'assets/images/image9.jpg'},
                      {'title': 'Hello', 'image': 'assets/images/image10.jpg'},
                      {'title': 'Too Sweet', 'image': 'assets/images/image11.jpg'},
                      {'title': 'Fresh', 'image': 'assets/images/image12.jpg'},
                    ];
                    final hit = popularHits[index];

                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: HoverCard(
                          title: hit['title']!,
                          image: hit['image']!,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Other categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 600;
            final itemSize = isWideScreen ? 180.0 : 150.0;
            return SizedBox(
              height: itemSize + 60,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6, (index) {
                    final bestPicks = [
                      {'title': 'Lorens Rixland', 'image': 'assets/images/image13.jpg'},
                      {'title': 'Elina Jodell', 'image': 'assets/images/image14.jpg'},
                      {'title': 'Caat', 'image': 'assets/images/image15.jpg'},
                      {'title': 'Sofia Carson', 'image': 'assets/images/image16.jpg'},
                      {'title': 'Coldplay', 'image': 'assets/images/image17.jpg'},
                      {'title': 'Hozier', 'image': 'assets/images/image18.jpg'},
                    ];
                    final pick = bestPicks[index];

                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              pick['image']!,
                              width: itemSize,
                              height: itemSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            pick['title']!,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}



class ArtistCard extends StatefulWidget {
  final String name;
  final String image;
  final double imageSize;
  final double textSize;

  const ArtistCard({
    Key? key,
    required this.name,
    required this.image,
    required this.imageSize,
    required this.textSize,
  }) : super(key: key);

  @override
  _ArtistCardState createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: SizedBox(
        height: 100.0,
        child: Card(
          color: _isHovered ? Colors.grey[700] : Colors.grey[900],
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: widget.imageSize / 2,
                    backgroundImage: AssetImage(widget.image),
                  ),
                ),
                Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.textSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class HoverCard extends StatefulWidget {
  final String title;
  final String image;

  const HoverCard({Key? key, required this.title, required this.image}) : super(key: key);

  @override
  _HoverCardState createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SongProfile(
                title: widget.title,
                image: widget.image,
              ),
            ),
          );
        },
        child: Card(
          color: _isHovered ? Colors.grey[700] : Colors.transparent,
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
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}