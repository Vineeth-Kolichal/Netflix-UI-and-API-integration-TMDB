import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';
part 'downloads_bloc.freezed.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';

@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadState> {
  final IDownloadsRrepo _downloadsRepo;
  DownloadsBloc(this._downloadsRepo) : super(DownloadState.initial()) {
    on<_GetDownloadsImage>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          downloadFailureOrSuccessOption: none(),
        ),
      );
      final Either<MainFailure, List<Downloads>> downloadsOption =
          await _downloadsRepo.getDownloadImages();
      log(downloadsOption.toString());
      emit(
        downloadsOption.fold(
          (failure) => state.copyWith(
            isLoading: false,
            downloadFailureOrSuccessOption: some(
              Left(failure),
            ),
          ),
          (success) => state.copyWith(
            isLoading: false,
            downloads: success,
            downloadFailureOrSuccessOption: Some(
              right(success),
            ),
          ),
        ),
      );
    });
  }
}
