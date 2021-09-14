import 'package:flutter/material.dart';
import 'package:lively/widgets/video_card.dart';
import 'package:lively/widgets/widgets.dart';

import '../data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 60.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index){
                    final playlist = livelyPlaylists[0];
                    return VideoCard(video: playlist.videos[index]);
                  },
                childCount: livelyPlaylists[0].videos.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
