import 'package:flutter/material.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/topTenTitleWithCard.dart';
import 'package:netflix/presentation/widgets/main_title_widget.dart';
import 'widgets/titleWithCardWidget.dart';

final String imageHome =
    'https://www.themoviedb.org/t/p/w220_and_h330_face/5YccrqvJFTfAVyEZp08I3fLx15y.jpg';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          TitleWithCardList(size: size, title: 'Released In the past year'),
          TitleWithCardList(size: size, title: 'Trending Now'),
          TopTenTitleWithCardList(size: size, title: 'Top Ten'),
          TitleWithCardList(size: size, title: 'Tense Dramas'),
          TitleWithCardList(size: size, title: 'South Indian Cinema')
        ],
      ),
    );
  }
}
