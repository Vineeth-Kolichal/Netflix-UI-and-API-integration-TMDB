import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/domain/hot_and_new%20_resp/models/hot_and_new_resp.dart';
import 'package:netflix/presentation/home/screen_home.dart';
import 'package:netflix/presentation/widgets/main_title_widget.dart';

class TitleWithCardList extends StatelessWidget {
  const TitleWithCardList({
    super.key,
    required this.size,
    required this.title,
    required this.imageList,
  });
  final String title;
  final Size size;
  final List<String?> imageList;

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
              children: List.generate(
                  10,
                  (index) => imageList.isEmpty
                      ? ImageListItem(size: size, image: null)
                      : ImageListItem(
                          size: size,
                          image: imageList[index],
                        ))),
        ),
      ],
    );
  }
}

class ImageListItem extends StatelessWidget {
  const ImageListItem({
    super.key,
    required this.size,
    required this.image,
  });
  final String? image;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: image == null
          ? SizedBox(
              width: size.width * 0.3,
              child: Text('failed to\nload\nImage'),
            )
          : Container(
              width: size.width * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageAppendUrl + image!)),
                borderRadius: kborderRadius,
              ),
            ),
    );
  }
}
