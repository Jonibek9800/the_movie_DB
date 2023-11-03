import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerWidget extends StatefulWidget {
  final String youTubeKey;

  const MovieTrailerWidget({super.key, required this.youTubeKey});

  @override
  State<MovieTrailerWidget> createState() => _MovieTrailerWidgetState();
}

class _MovieTrailerWidgetState extends State<MovieTrailerWidget> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.youTubeKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        onReady: () {
          // _controller.addListener();
        });
    return YoutubePlayerBuilder(
        player: player,
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                "Трейлер",
                style: TextStyle(color: Color(0xFF20B9D6)),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: player,
            ),
          );
        });
  }
}
