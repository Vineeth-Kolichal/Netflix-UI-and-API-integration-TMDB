import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/new_and_hot/widgets/description_text_widget.dart';
import 'package:netflix/presentation/new_and_hot/widgets/image_with_mute.dart';

class EveryonesWatching extends StatelessWidget {
  const EveryonesWatching({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryoneIsWatching());
    });
    final Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryoneIsWatching());
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
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return const Center(
              child: Text('List is empty'),
            );
          } else {
            return ListView.separated(
              itemBuilder: ((context, index) {
                final tv = state.everyOneIsWatchingList[index];
                return EveryoneWatchingItem(
                    size: size,
                    id: tv.id.toString(),
                    imagePath: tv.backdropPath,
                    movieName: tv.originalName!,
                    description: tv.overview!);
              }),
              separatorBuilder: (context, index) {
                return kHeight;
              },
              itemCount: state.everyOneIsWatchingList.length,
            );
          }
        },
      ),
    );
  }
}

class EveryoneWatchingItem extends StatelessWidget {
  final String id;
  final String? imagePath;
  final String movieName;
  final String description;
  const EveryoneWatchingItem({
    super.key,
    required this.size,
    required this.id,
    required this.imagePath,
    required this.movieName,
    required this.description,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          DescriptionTextWidget(
            description: description,
            title: movieName,
          ),
          const SizedBox(
            height: 25,
          ),
          ImageWithMuteButton(
              size: size,
              widthPercet: 1,
              heightpercent: 0.6,
              imgPath: imagePath),
          kHeight20,
          SizedBox(
            height: 50,
            child: Row(
              children: [
                kWidth,
                const Text(
                  'LOST\nIN\nSPACE',
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(CupertinoIcons.paperplane),
                    Text('Share')
                  ],
                ),
                kWidth,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(CupertinoIcons.add),
                    Text('My List'),
                  ],
                ),
                kWidth,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [Icon(CupertinoIcons.play), Text('Play')],
                ),
                kWidth,
              ],
            ),
          ),
          kHeight20,
        ],
      ),
    );
  }
}
