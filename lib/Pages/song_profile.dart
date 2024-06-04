import 'package:flutter/material.dart';
import 'package:my_project/widgets/playback_bar.dart';
import 'dart:ui';
import '../utils/favorite_manager.dart';
class SongProfile extends StatefulWidget {
  final String title;
  final String image;

  const SongProfile({Key? key, required this.title, required this.image}) : super(key: key);

  @override
  _SongProfileState createState() => _SongProfileState();
}

class _SongProfileState extends State<SongProfile> {
  @override
  Widget build(BuildContext context) {
    bool _isFavorite = UserFavoriteManager.isFavorite(widget.title);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            widget.image,
                            width: isMobile ? 250 : 300,
                            height: isMobile ? 250 : 300,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    PlaybackBar(),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                      UserFavoriteManager.toggleFavorite(widget.title, widget.image);
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}
