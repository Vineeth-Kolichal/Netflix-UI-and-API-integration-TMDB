import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/home/screen_home.dart';
import 'package:netflix/presentation/widgets/main_title_widget.dart';

class TopTenTitleWithCardList extends StatelessWidget {
  const TopTenTitleWithCardList({
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
                  (index) => TopTenImageListItem(
                        image: imageList[index],
                        size: size,
                        index: index,
                      ))),
        ),
      ],
    );
  }
}

class TopTenImageListItem extends StatelessWidget {
  const TopTenImageListItem({
    super.key,
    required this.size,
    required this.index,
    required this.image,
  });
  final int index;
  final Size size;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              image == null
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
            ],
          ),
          Positioned(
            left: -3,
            bottom: -20,
            child: BorderedText(
              strokeWidth: 2,
              strokeColor: kWhiteColor,
              child: Text(
                '${index + 1}',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: kTextColorBlack,
                      fontSize: size.width * 0.35,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
