import 'package:flutter/material.dart';
import 'package:lively/screens/nav_screen.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({Key? key, required this.video, this.hasPadding = false, this.onTap}) : super(key: key);

  final Video video;
  final bool hasPadding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()  {
        context.read(selectedVideoProvider).state = video;
        context.read(miniPlayerControllerProvider).state.animateToHeight(state: PanelState.MAX);
        if(onTap != null) onTap!();
      },
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hasPadding ? 12.0 : 0),
                child: Image.network(
                  video.thumbnails.standardResUrl,
                  height: 220.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 8.0,
                right: hasPadding ? 20.0 : 8.0,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  color: Colors.black,
                  child: Text(
                    video.duration?.inMinutes?.toString() ?? "NA",
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(video.thumbnails.lowResUrl),
                  ),
                  onTap: () => {print("User account")},
                ),
                const SizedBox(width: 8.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          video.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15.0),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          video.author,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14.0),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => {},
                    child: const Icon(Icons.more_vert, size: 20.0,)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
