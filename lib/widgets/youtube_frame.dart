import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeFrame extends StatefulWidget {

  Video video;

  YoutubeFrame( {required this.video, Key? key}) : super(key: key);

  @override
  _YoutubeFrameState createState() => _YoutubeFrameState();
}

class _YoutubeFrameState extends State<YoutubeFrame> {

  _buildYoutubeFrame(){

    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: widget.video.id.value,
      params: const YoutubePlayerParams(
        startAt: Duration(seconds: 30),
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    return SizedBox(
      height: 40.0,
      width: 100.0,
      child: YoutubePlayerIFrame(
        controller: _controller,
        aspectRatio: 16 / 9,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildYoutubeFrame();
  }
}
