import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lively/widgets/video_card.dart';
import 'package:lively/widgets/video_info.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'nav_screen.dart';

class VideoScreen extends StatefulWidget {
  final List<Video> playlistVideos;

  const VideoScreen({Key? key, required this.playlistVideos}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ScrollController? _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  _buildYoutubeFrame(Video? video){
    if(video == null) return const Text("Loading..");
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: video.id.value,
      params: const YoutubePlayerParams(
        startAt: Duration(seconds: 30),
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    return YoutubePlayerIFrame(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read(miniPlayerControllerProvider).state.animateToHeight(state: PanelState.MAX);
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Consumer(builder: (context, watch, _) {
                  final selectedVideo = watch(selectedVideoProvider).state;
                  return SafeArea(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            _buildYoutubeFrame(selectedVideo),
                            IconButton(
                              iconSize: 30.0,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                              ),
                              onPressed: () => {
                                context
                                    .read(miniPlayerControllerProvider)
                                    .state
                                    .animateToHeight(state: PanelState.MIN)
                              },
                            )
                          ],
                        ),
                        VideoInfo(video: selectedVideo!),
                      ],
                    ),
                  );
                }),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final video = widget.playlistVideos[index];
                  return VideoCard(
                    video: video,
                    hasPadding: true,
                    onTap: () {
                      _scrollController!.animateTo(0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    },
                  );
                }, childCount: widget.playlistVideos.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
