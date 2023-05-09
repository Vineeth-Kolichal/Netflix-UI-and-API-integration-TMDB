import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/presentation/new_and_hot/widgets/description_text_widget.dart';
import 'package:netflix/presentation/new_and_hot/widgets/image_with_mute.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });
    final Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Something Error'),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text('List is empty'),
            );
          } else {
            return ListView.separated(
                itemCount: state.comingSoonList.length,
                separatorBuilder: (context, index) {
                  return kHeight;
                },
                itemBuilder: (ctx, index) {
                  final movie = state.comingSoonList[index];
                  List<String> date = movie.releaseDate!.split('-');
                  return ComingSoonItem(
                      size: size,
                      id: movie.id.toString(),
                      month: returnMonth(int.parse(date[1])),
                      day: date[2],
                      imagePath: movie.backdropPath != null
                          ? '$imageAppendUrl${movie.backdropPath}'
                          : 'No Image found',
                      movieName: movie.originalTitle ?? 'No title',
                      description: movie.overview ?? 'No description found');
                });
          }
        },
      ),
    );
  }

  String returnMonth(int month) {
    switch (month) {
      case 1:
        return 'JAN';
      case 2:
        return 'FEB';
      case 3:
        return 'MAR';
      case 4:
        return 'APR';
      case 5:
        return 'MAY';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AUG';
      case 9:
        return 'JAN';
      case 10:
        return 'SEP';
      case 11:
        return 'OCT';
      case 12:
        return 'NOV';
      default:
        return '??';
    }
  }
}

class ComingSoonItem extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String imagePath;
  final String movieName;
  final String description;
  const ComingSoonItem(
      {super.key,
      required this.size,
      required this.id,
      required this.month,
      required this.day,
      required this.imagePath,
      required this.movieName,
      required this.description});
  final Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: size.width * 0.15,
          child: Column(
            children: [
              Text(
                month,
                style: const TextStyle(color: Colors.grey),
              ),
              Text(
                day,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageWithMuteButton(
                  imgPath: imagePath,
                  size: size,
                  heightpercent: 0.5,
                  widthPercet: 0.85),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.45,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        movieName,
                        style: GoogleFonts.antonio(
                            fontSize: size.width * 0.09,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
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
                        children: const [
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
                'Coming on $day $month',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white60),
              ),
              kHeight,
              DescriptionTextWidget(
                title: movieName,
                description: description,
              )
            ],
          ),
        )
      ]),
    );
  }
}
