import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lively/widgets/video_card.dart';
import 'package:lively/widgets/widgets.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';


class PlaylistScreen extends ConsumerWidget {

  PlaylistScreen({required this.provider, required this.title, Key? key,}) : super(key: key);

  final FutureProvider<List<Video>> provider;
  final String title;

  List<Video> videos = List.empty();


  @override
  Widget build(BuildContext context, ScopedReader watch) {
    watch(provider).whenData((List<Video> value)  {
      videos = value;
    });
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(title: title,),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 60.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index){
                  return VideoCard(video: videos[index]);
                },
                childCount: videos.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
