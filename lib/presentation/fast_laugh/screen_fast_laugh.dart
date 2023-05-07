import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/presentation/fast_laugh/widget/video_list_item.dart';

class ScreenFastLaugh extends StatefulWidget {
  const ScreenFastLaugh({Key? key}) : super(key: key);

  @override
  _ScreenFastLaughState createState() => _ScreenFastLaughState();
}

class _ScreenFastLaughState extends State<ScreenFastLaugh> {
  late FastLaughBloc _fastLaughBloc;

  @override
  void initState() {
    super.initState();
    _fastLaughBloc = BlocProvider.of<FastLaughBloc>(context);
    _fastLaughBloc.add(const Initialize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FastLaughBloc, FastLaughState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.isError) {
              return Center(
                child: Text('Error Occurred'),
              );
            } else if (state.videosList.isEmpty) {
              return Center(
                child: Text('Video List empty'),
              );
            } else {
              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.videosList.length,
                itemBuilder: (context, index) {
                  return VideoListItemInheritedWidget(
                    widget: VideoListItem(
                      key: Key(index.toString()),
                      index: index,
                    ),
                    movieData: state.videosList[index],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
