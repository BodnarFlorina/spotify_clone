import 'package:flutter/material.dart';

class UserFavoriteManager {
  static final ValueNotifier<List<Map<String, String>>> _favoriteSongs = ValueNotifier<List<Map<String, String>>>([
    {'title': 'Home', 'image': 'assets/images/favorite2.jpg'},
    {'title': 'Summer vibe', 'image': 'assets/images/favorite3.jpg'},
  ]);

  static ValueNotifier<List<Map<String, String>>> getFavorites() => _favoriteSongs;

  static void toggleFavorite(String title, String image) {
    final favorite = _favoriteSongs.value.firstWhere(
      (song) => song['title'] == title,
      orElse: () => {},
    );

    if (favorite.isNotEmpty) {
      _favoriteSongs.value = List.from(_favoriteSongs.value)..remove(favorite);
    } else {
      _favoriteSongs.value = List.from(_favoriteSongs.value)
        ..add({'title': title, 'image': image});
    }
    _favoriteSongs.notifyListeners();
  }

  static bool isFavorite(String title) {
    return _favoriteSongs.value.any((song) => song['title'] == title);
  }
}
