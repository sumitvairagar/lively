import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'models/playlist.dart';

final youtubeExplodeProvider = StateProvider<YoutubeExplode>((ref) => YoutubeExplode());

final youtubePlayerControllerProvider  = StateProvider<YoutubePlayerController>((ref) =>
  YoutubePlayerController(
    initialVideoId: video.id.value,
    params: const YoutubePlayerParams(
    startAt: Duration(seconds: 30),
    showControls: true,
    showFullscreenButton: true,
  ))
);

final newsPlayListProvider = FutureProvider<List<Video>>((ref)  async {
  var newsPlaylist = LivelyPlayList("PL4cUxeGkcC9gjxLvV4VEkZ6H6H4yWuS58", "Material UI", null);
  var yt = ref.watch(youtubeExplodeProvider).state;
  var future = await yt.playlists.getVideos(newsPlaylist.playListId).toList();
  return future;
});

final sportsPlayListProvider = FutureProvider<List<Video>>((ref)  async {
  var newsPlaylist = LivelyPlayList("PL4cUxeGkcC9gjxLvV4VEkZ6H6H4yWuS58", "Material UI", null);
  var yt = ref.watch(youtubeExplodeProvider).state;
  var future = await yt.playlists.getVideos(newsPlaylist.playListId).toList();
  return future;
});

final musicPlayListProvider = FutureProvider<List<Video>>((ref)  async {
  var newsPlaylist = LivelyPlayList("PL4cUxeGkcC9gjxLvV4VEkZ6H6H4yWuS58", "Material UI", null);
  var yt = ref.watch(youtubeExplodeProvider).state;
  var future = await yt.playlists.getVideos(newsPlaylist.playListId).toList();
  return future;
});