import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/downloads/downloads_bloc.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/widgets/custom_app_bar.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});
  List<Widget> _widgets = [
    const _SmartDownloads(),
    Section2(),
    const Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: CustomAppBar(
              leading: Text('Downloads',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
            )),
        body: ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (ctx, index) {
            return _widgets[index];
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(
              height: 20,
            );
          },
          itemCount: _widgets.length,
        ));
  }
}

class Section2 extends StatelessWidget {
  Section2({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Text(
          'Introducing Downloads for you',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        kHeight,
        const Text(
          'We will download a personalized selection of\nmovies and shows for you. So there is \nalways something to watch on your \ndevice. ',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        BlocBuilder<DownloadsBloc, DownloadState>(
          builder: (context, state) {
            if (state.isLoading) {
              return SizedBox(
                height: size.width,
                width: size.width,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            if (state.downloads.isEmpty) {
              return SizedBox(
                height: size.width,
                width: size.width,
                child: const Center(child: CircularProgressIndicator()),
              );
            } else {
              return SizedBox(
                height: size.width,
                width: size.width,
                child: Stack(alignment: Alignment.center, children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(144, 158, 158, 158),
                    radius: size.width * 0.37,
                  ),
                  DownloadImageWidget(
                      size: Size(size.width * 0.38, size.width * 0.54),
                      imagePath:
                          '$imageAppendUrl${state.downloads[0].posterPath}',
                      rotationAngle: -20,
                      margin:
                          EdgeInsets.only(right: size.width * 0.4, bottom: 35)),
                  DownloadImageWidget(
                      size: Size(size.width * 0.38, size.width * 0.54),
                      imagePath:
                          '$imageAppendUrl${state.downloads[1].posterPath}',
                      rotationAngle: 20,
                      margin:
                          EdgeInsets.only(left: size.width * 0.4, bottom: 35)),
                  DownloadImageWidget(
                      size: Size(size.width * 0.42, size.width * 0.6),
                      imagePath:
                          '$imageAppendUrl${state.downloads[2].posterPath}',
                      rotationAngle: 0,
                      margin: const EdgeInsets.only(top: 10))
                ]),
              );
            }
          },
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
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
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
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
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
        const Icon(Icons.settings),
        kWidth,
        const Text('Smart Downloads'),
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
