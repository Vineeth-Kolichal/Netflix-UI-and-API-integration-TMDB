import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';

import 'search_title_widget.dart';

const String imageUrl =
    'https://www.themoviedb.org/t/p/w250_and_h141_face/6Lw54zxm6BAEKJeGlabyzzR5Juu.jpg';

class SearchIdle extends StatelessWidget {
  const SearchIdle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchTitileWidget(title: 'Top Searches'),
        kHeight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return Center(
                  child: Text('Error while getting data'),
                );
              } else if (state.idleList.isEmpty) {
                return Center(
                  child: Text('List is Empty'),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return TopSearchItemTile(
                    title: state.idleList[index].title ?? 'No title Provided',
                    imgPath:
                        '$imageAppendUrl${state.idleList[index].posterPath}',
                  );
                },
                separatorBuilder: (ctx, index) {
                  return kHeight20;
                },
                itemCount: state.idleList.length,
              );
            },
          ),
        ),
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  const TopSearchItemTile(
      {super.key, required this.imgPath, required this.title});
  final String imgPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          Container(
            width: size.width * 0.33,
            height: size.width * 0.17,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imgPath),
              ),
            ),
          ),
          kWidth,
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Icon(
            CupertinoIcons.play_circle,
            size: 50,
          )
        ],
      ),
    );
  }
}
