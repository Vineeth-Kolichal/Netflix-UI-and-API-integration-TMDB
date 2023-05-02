import 'dart:math';

import 'package:flutter/material.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/widgets/custom_app_bar.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});
  List<Widget> _widgets = [
    _SmartDownloads(),
    Section2(),
    Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              title: 'Downloads',
            )),
        body: ListView.separated(
          padding: EdgeInsets.all(10),
          itemBuilder: (ctx, index) {
            return _widgets[index];
          },
          separatorBuilder: (ctx, index) {
            return SizedBox(
              height: 20,
            );
          },
          itemCount: _widgets.length,
        ));
  }
}

class Section2 extends StatelessWidget {
  Section2({super.key});

  List<String> imagePath = [
    'https://www.themoviedb.org/t/p/w220_and_h330_face/5jHnykugFB3awLTwDM5LQ93TIzs.jpg',
    'https://www.themoviedb.org/t/p/w220_and_h330_face/dP1Xoc3X76Q97OUCpQTN9hftUST.jpg',
    'https://www.themoviedb.org/t/p/w220_and_h330_face/fXgY2RCzoIJPhPDoyKRjaaqjIZs.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Text(
          'Introducing Downloads for you',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        kHeight,
        Text(
          'We will download a personalized selection of\nmovies and shows for you. So there is \nalways something to watch on your \ndevice. ',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        Container(
          height: size.width,
          width: size.width,
          child: Stack(alignment: Alignment.center, children: [
            CircleAvatar(
              backgroundColor: Color.fromARGB(144, 158, 158, 158),
              radius: size.width * 0.37,
            ),
            DownloadImageWidget(
                size: Size(size.width * 0.38, size.width * 0.54),
                imagePath: imagePath[2],
                rotationAngle: -20,
                margin: EdgeInsets.only(right: 155, bottom: 35)),
            DownloadImageWidget(
                size: Size(size.width * 0.38, size.width * 0.54),
                imagePath: imagePath[1],
                rotationAngle: 20,
                margin: EdgeInsets.only(left: 155, bottom: 35)),
            DownloadImageWidget(
                size: Size(size.width * 0.42, size.width * 0.6),
                imagePath: imagePath[0],
                rotationAngle: 0,
                margin: EdgeInsets.only(top: 10))
          ]),
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: kButtomColorBlue,
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Setup',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        kHeight,
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          color: kButtonColorWhite,
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'See what you can download',
              style: TextStyle(
                color: kTextColorBlack,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        kWidth,
        Icon(Icons.settings),
        kWidth,
        Text('Smart Downloads'),
      ],
    );
  }
}

class DownloadImageWidget extends StatelessWidget {
  const DownloadImageWidget({
    super.key,
    required this.size,
    required this.imagePath,
    required this.rotationAngle,
    required this.margin,
  });
  final double rotationAngle;
  final Size size;
  final String imagePath;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationAngle * pi / 180,
      child: Container(
        margin: margin,
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            image: DecorationImage(
                image: NetworkImage(imagePath), fit: BoxFit.cover)),
      ),
    );
  }
}
