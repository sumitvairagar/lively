import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class LivelyPlayList{
  final String playListId;
  final String title;
  Playlist? playlist;
  final List<Video> videos = List.empty(growable: true);

  LivelyPlayList(this.playListId, this.title, this.playlist);

}