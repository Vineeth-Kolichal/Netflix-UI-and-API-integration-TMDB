import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/screen_home.dart';
import 'package:netflix/presentation/widgets/main_title_widget.dart';

class TopTenTitleWithCardList extends StatelessWidget {
  const TopTenTitleWithCardList({
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
              children: List.generate(
                  10,
                  (index) => TopTenImageListItem(
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
  });
  final int index;
  final Size size;

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
              Container(
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(imageHome)),
                  color: Colors.amber,
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
