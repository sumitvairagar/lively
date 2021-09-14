import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:lively/top_level_providers.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../data.dart';
import 'package:timeago/timeago.dart' as timeago;

class VideoInfo extends StatelessWidget {
  const VideoInfo({Key? key, required this.video}) : super(key: key);

  final Video video;

  @override
  Widget build(BuildContext context) {
    final yt = context.read(youtubeExplodeProvider).state;
    //var channel = yt.channels.getByUsername(video.author);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(video.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 15.0)),
          const SizedBox(
            height: 8.0,
          ),
          Text('${ video.engagement.likeCount.toString()}}',
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(fontSize: 14.0)),
          const Divider(),
          _ActionsRow(video: video),
          const Divider(),
          /*_AuthorInfo(
            user: ,
          ),*/
          const Divider(),
        ],
      ),
    );
  }
}

class _ActionsRow extends StatelessWidget {
  const _ActionsRow({Key? key, required this.video}) : super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        /*_buildAction(context, Icons.thumb_up_outlined, video.engagement.likeCount.toString()),
        _buildAction(context, Icons.thumb_down_outlined, video.engagement.dislikeCount.toString()),*/
        _buildAction(context, Icons.reply_outlined, 'Share'),
        /*_buildAction(context, Icons.download_outlined, 'Download'),
        _buildAction(context, Icons.library_add_outlined, 'Save'),*/
      ],
    );
  }

  Widget _buildAction(BuildContext context, IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(
            height: 6.0,
          ),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class _AuthorInfo extends StatelessWidget {
  const _AuthorInfo({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(foregroundImage: NetworkImage(user.profileImageUrl)),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  user.username,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15.0),
                ),
              ),
              Flexible(
                child: Text(
                  '${user.subscribers} subscribers',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 14.0),
                ),
              )
            ],
          ),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              'SUBSCRIBE',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.red),
            ))
      ],
    );
  }
}
