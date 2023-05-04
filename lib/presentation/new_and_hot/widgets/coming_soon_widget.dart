import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/new_and_hot/widgets/description_text_widget.dart';
import 'package:netflix/presentation/new_and_hot/widgets/image_with_mute.dart';
import 'package:netflix/presentation/search/widgets/search_idle.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      children: [
        ComingSoonItem(
          size: size,
        ),
        kHeight,
        ComingSoonItem(
          size: size,
        ),
        kHeight,
        ComingSoonItem(
          size: size,
        )
      ],
    );
  }
}

class ComingSoonItem extends StatelessWidget {
  const ComingSoonItem({super.key, required this.size});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: size.width * 0.15,
          child: Column(
            children: [
              Text(
                'FEB',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '11',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        Container(
          width: size.width * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWithMuteButton(size: size,heightpercent:0.5 ,widthPercet:0.85 ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Text(
                      'TALLGIRL2',
                      style: GoogleFonts.antonio(
                          fontSize: size.width * 0.09,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(CupertinoIcons.bell),
                          Text('Remind Me'),
                        ],
                      ),
                    ),
                    kWidth,
                    SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(CupertinoIcons.info),
                          Text('info'),
                        ],
                      ),
                    ),
                    kWidth,
                    kWidth,
                  ],
                ),
              ),
              Text(
                'Coming on Friday',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white60),
              ),
              kHeight,
              DescriptionTextWidget(
                title: 'Tall Girl 2',
                description:
                    'Landing the lead in the school musical is a dream come true for Jodi,Untill the pressure sends her confidence--and her relationship into a talspin.',
              )
            ],
          ),
        )
      ]),
    );
  }
}
