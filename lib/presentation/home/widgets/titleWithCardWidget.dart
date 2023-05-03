import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/screen_home.dart';
import 'package:netflix/presentation/widgets/main_title_widget.dart';

class TitleWithCardList extends StatelessWidget {
  const TitleWithCardList({
    super.key,
    required this.size,
    required this.title,
  });
  final String title;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitileWidget(title: title),
        kHeight,
        SizedBox(
          width: size.width,
          height: size.width * 0.44,
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children:
                  List.generate(10, (index) => ImageListItem(size: size))),
        ),
      ],
    );
  }
}

class ImageListItem extends StatelessWidget {
  const ImageListItem({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: size.width * 0.3,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(imageHome)),
          color: Colors.amber,
          borderRadius: kborderRadius,
        ),
      ),
    );
  }
}
