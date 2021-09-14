import 'package:flutter/material.dart';

import '../data.dart';

class CustomSliverAppBar extends StatelessWidget {

  const CustomSliverAppBar({this.title = "", Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leadingWidth: 100.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 10.0),
        child: Text("Lively", style: Theme.of(context).textTheme.headline4,),
      ),
      title: Text(title, style: Theme.of(context).textTheme.headline4,),
      actions:  [
        IconButton(onPressed: () => {}, icon: const Icon(Icons.search)),
        /*IconButton(onPressed: () {}, icon: const Icon(Icons.cast)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(
          iconSize: 40.0,
          onPressed: () {},
          icon: CircleAvatar(
            foregroundImage: NetworkImage(currentUser.profileImageUrl),
          ),
        ),*/
      ],
      floating: true,
    );
  }
}
