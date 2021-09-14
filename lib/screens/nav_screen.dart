import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lively/screens/playlist_screen.dart';
import 'package:lively/screens/video_screen.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../top_level_providers.dart';

final selectedVideoProvider = StateProvider<Video?>((ref) => null);

final selectedPlaylistVideosProvider = StateProvider<List<Video>?>((ref) => null);

final miniPlayerControllerProvider = StateProvider.autoDispose<MiniplayerController>((ref) => MiniplayerController());

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  static const double _playerMinHeight = 60.0;

  final _screens = [
    PlaylistScreen( provider: newsPlayListProvider, title: "News"),
    PlaylistScreen( provider: sportsPlayListProvider, title: "Sports"),
    PlaylistScreen( provider: musicPlayListProvider, title: "Music"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, _) {
          final selectedVideo = watch(selectedVideoProvider).state;
          final selectedPlaylistVideos = watch(selectedPlaylistVideosProvider).state;
          final miniPlayerController = watch(miniPlayerControllerProvider).state;
          return Stack(
            children: _screens
                .asMap()
                .map(
                  (i, screen) => MapEntry(
                    i,
                    Offstage(
                      offstage: i != _selectedIndex,
                      child: screen,
                    ),
                  ),
                )
                .values
                .toList()
              ..add(
                Offstage(
                  offstage: selectedVideo == null,
                  child: Miniplayer(
                      controller: miniPlayerController,
                      minHeight: _playerMinHeight,
                      maxHeight: MediaQuery.of(context).size.height,
                      builder: (height, percentage) {
                        if (selectedVideo == null) {
                          return const SizedBox.shrink();
                        }
                       if(height >= _playerMinHeight + 50){
                         return VideoScreen(playlistVideos: selectedPlaylistVideos ?? List.empty());
                       }else{
                         return _smallPlayer(context, selectedVideo);
                       }
                      }),
                ),
              ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.feed_outlined),
            activeIcon: Icon(Icons.feed),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.run_circle_outlined),
            activeIcon: Icon(Icons.run_circle),
            label: 'Sports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note_outlined),
            activeIcon: Icon(Icons.music_note),
            label: 'Music',
          ),
        ],
      ),
    );
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

  Container _smallPlayer(BuildContext context, Video selectedVideo) {
    return Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  child:  _buildYoutubeFrame(selectedVideo),
                                  height: 60,
                                  width: 120,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          selectedVideo.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w500),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          selectedVideo.author,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () => {
                                          context
                                              .read(selectedVideoProvider)
                                              .state = null
                                        },
                                    icon: const Icon(Icons.close))
                              ],
                            ),
                          ],
                        ),
                      );
  }
}
