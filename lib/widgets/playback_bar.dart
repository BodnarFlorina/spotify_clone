import 'package:flutter/material.dart';
import 'dart:async';

class PlaybackBar extends StatefulWidget {
  const PlaybackBar({Key? key}) : super(key: key);

  @override
  _PlaybackBarState createState() => _PlaybackBarState();
}

class _PlaybackBarState extends State<PlaybackBar> {
  Timer? _timer;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _duration = Duration(minutes: 1, seconds: 13);
  final ValueNotifier<double> _progress = ValueNotifier(0.0);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _currentPosition = _currentPosition + Duration(seconds: 1);
          _progress.value = _currentPosition.inSeconds / _duration.inSeconds;

          if (_currentPosition >= _duration) {
            _timer?.cancel();
            _isPlaying = false;
            _currentPosition = Duration.zero;
            _progress.value = 0.0;
          }
        });
      });
    } else {
      _timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<double>(
          valueListenable: _progress,
          builder: (context, value, child) {
            return Slider(
              value: value,
              onChanged: (newValue) {
                setState(() {
                  _currentPosition = Duration(seconds: (_duration.inSeconds * newValue).round());
                  _progress.value = newValue;
                });
              },
              activeColor: Colors.white,
              inactiveColor: Colors.white.withOpacity(0.5),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.skip_previous, color: Colors.white),
              onPressed: () {
              },
            ),
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
              onPressed: _togglePlayPause,
            ),
            IconButton(
              icon: Icon(Icons.skip_next, color: Colors.white),
              onPressed: () {
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.stop, color: Colors.white),
              onPressed: () {
                setState(() {
                  _timer?.cancel();
                  _isPlaying = false;
                  _currentPosition = Duration.zero;
                  _progress.value = 0.0;
                });
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(_currentPosition),
                style: TextStyle(color: Colors.white),
              ),
              Text(
                _formatDuration(_duration),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
