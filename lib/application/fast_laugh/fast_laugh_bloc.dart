import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final dummyVideoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"
];

ValueNotifier<Set<int>> likedVideoIdsNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(IDownloadsRrepo _downloadService)
      : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      //sending loading
      emit(FastLaughState(
        videosList: [],
        isLoading: true,
        isError: false,
      ));
      //get trending movies
      final _result = await _downloadService.getDownloadImages();
      final _state = _result.fold(
          (l) => FastLaughState(
                videosList: [],
                isLoading: false,
                isError: true,
              ),
          (resp) => FastLaughState(
                videosList: resp,
                isLoading: false,
                isError: false,
              ));
      //send to ui
      emit(_state);
    });

    on<LikeVideo>((event, emit) async {
      likedVideoIdsNotifier.value.add(event.id);
    });
    on<UnlikeVideo>((event, emit) {
      likedVideoIdsNotifier.value.remove(event.id);
    });
  }
}
