import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home_bloc/home_bloc.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/topTenTitleWithCard.dart';
import 'package:netflix/presentation/widgets/custom_app_bar.dart';
import 'widgets/background_image_card.dart';
import 'widgets/titleWithCardWidget.dart';

const String imageHome =
    'https://www.themoviedb.org/t/p/w220_and_h330_face/5YccrqvJFTfAVyEZp08I3fLx15y.jpg';
ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: scrollNotifier,
          builder: (BuildContext context, bool value, _) {
            return Stack(
              children: [
                NotificationListener<UserScrollNotification>(
                  onNotification: (notification) {
                    final ScrollDirection direction = notification.direction;
                    if (direction == ScrollDirection.forward) {
                      scrollNotifier.value = true;
                    } else if (direction == ScrollDirection.reverse) {
                      scrollNotifier.value = false;
                    }
                    return true;
                  },
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      } else if (state.isError) {
                        return const Center(
                          child: Text('Something Error'),
                        );
                      } else {
                        final pastYear = state.pastYearMovieList.map((e) {
                          return e.posterPath;
                        }).toList();
                        final trending = state.trendingMovieList.map((e) {
                          return e.posterPath;
                        }).toList();
                        final tense = state.tenseMovieList.map((e) {
                          return e.posterPath;
                        }).toList();
                        final south = state.southIndianMovieList.map((e) {
                          return e.posterPath;
                        }).toList();
                        final topTen = state.trendingTvList.map((e) {
                          return e.posterPath;
                        }).toList();
                        trending.shuffle();
                        tense.shuffle();
                        south.shuffle();

                        return ListView(
                          children: [
                            BackgroundImageCard(
                                size: size,
                                image: pastYear.isEmpty ? null : pastYear[5]),
                            TitleWithCardList(
                              imageList: pastYear,
                              size: size,
                              title: 'Released In the past year',
                            ),
                            kHeight,
                            TitleWithCardList(
                              imageList: trending,
                              size: size,
                              title: 'Trending Now',
                            ),
                            kHeight,
                            TopTenTitleWithCardList(
                              imageList: topTen,
                              size: size,
                              title: 'Top Ten TV Shows In India Today',
                            ),
                            kHeight,
                            TitleWithCardList(
                              imageList: tense,
                              size: size,
                              title: 'Tense Dramas',
                            ),
                            kHeight,
                            TitleWithCardList(
                              imageList: south,
                              size: size,
                              title: 'South Indian Cinema',
                            )
                          ],
                        );
                      }
                    },
                  ),
                ),
                scrollNotifier.value == false
                    ? kHeight
                    : AnimatedContainer(
                        curve: Curves.ease,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Color.fromARGB(172, 0, 0, 0),
                              Colors.transparent
                            ])),
                        duration: const Duration(milliseconds: 1000),
                        height: size.width * 0.25,
                        child: Column(children: [
                          CustomAppBar(
                            leading: Image.network(
                                height: size.width * 0.09,
                                width: size.width * 0.09,
                                'https://pngimg.com/d/netflix_PNG15.png'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'TV Shows',
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Movies',
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Categories',
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ]),
                      )
              ],
            );
          }),
    );
  }
}
