import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/core/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/core/strings.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInheritedWidget(
      {super.key, required this.widget, required this.movieData})
      : super(child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  const VideoListItem({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(videoUrl: videoUrl, onStateChanged: (bool) {}),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //left side items
                CircleAvatar(
                  backgroundColor: Color.fromARGB(129, 0, 0, 0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.volume_off,
                      color: kWhiteColor,
                    ),
                  ),
                ),

                //right
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: posterPath == null
                          ? null
                          : NetworkImage('$imageAppendUrl$posterPath'),
                    ),
                    ValueListenableBuilder(
                      valueListenable: likedVideoIdsNotifier,
                      builder:
                          (BuildContext ctx, Set<int> newLiked, Widget? _) {
                        final idx = index;
                        if (newLiked.contains(idx)) {
                          return GestureDetector(
                            onTap: () {
                              likedVideoIdsNotifier.value.remove(index);
                              likedVideoIdsNotifier.notifyListeners();
                              // BlocProvider.of<FastLaughBloc>(context)
                              //     .add(UnlikeVideo(id: idx));
                            },
                            child: const VideoActions(
                                title: 'Liked', icon: Icons.favorite),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            print(
                                '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}');

                            likedVideoIdsNotifier.value.add(index);
                            likedVideoIdsNotifier.notifyListeners();
                          },
                          child: VideoActions(
                              title: 'LOL',
                              icon: Icons.favorite_border_outlined),
                        );
                      },
                    ),
                    VideoActions(title: 'My List', icon: Icons.add),
                    GestureDetector(
                        onTap: () {
                          final moiveName =
                              VideoListItemInheritedWidget.of(context)
                                  ?.movieData
                                  .title;
                          if (moiveName != null) {
                            Share.share(moiveName);
                          }
                        },
                        child: VideoActions(title: 'Share', icon: Icons.share)),
                    VideoActions(title: 'Play', icon: Icons.play_arrow)
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class VideoActions extends StatelessWidget {
  final String title;
  final IconData icon;
  const VideoActions({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer(
      {super.key, required this.videoUrl, required this.onStateChanged});

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {
        _videoPlayerController.play();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
