import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix/core/constants.dart';

import 'search_title_widget.dart';

const String imageUrl =
    'https://www.themoviedb.org/t/p/w250_and_h141_face/6Lw54zxm6BAEKJeGlabyzzR5Juu.jpg';

class SearchIdle extends StatelessWidget {
  const SearchIdle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchTitileWidget(title: 'Top Searches'),
        kHeight,
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return TopSearchItemTile();
            },
            separatorBuilder: (ctx, index) {
              return kHeight20;
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  const TopSearchItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          Container(
            width: size.width * 0.33,
            height: size.width * 0.17,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Movie Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Icon(
            CupertinoIcons.play_circle,
            size: 50,
          )
        ],
      ),
    );
  }
}
