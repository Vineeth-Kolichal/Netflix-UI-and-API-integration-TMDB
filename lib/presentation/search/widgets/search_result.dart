import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/domain/search/model/search_resp/search_resp.dart';
import 'package:netflix/presentation/search/widgets/search_title_widget.dart';

const String imgUrlVertical =
    'https://www.themoviedb.org/t/p/w220_and_h330_face/5jHnykugFB3awLTwDM5LQ93TIzs.jpg';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.resultList});
  final List<SearchResultData> resultList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchTitileWidget(title: 'Movies & TV'),
        kHeight,
        Expanded(
            child: GridView.count(
          childAspectRatio: 1 / 1.4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          shrinkWrap: true,
          crossAxisCount: 3,
          children: List.generate(resultList.length, (index) {
            if (resultList[index].posterPath != null) {
              return MainCard(
                imgUrl: '$imageAppendUrl${resultList[index].posterPath}',
              );
            } else {
              return Center(
                child: Text('Image not found'),
              );
            }
          }),
        ))
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  const MainCard({super.key, required this.imgUrl});
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imgUrl),
        ),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}
