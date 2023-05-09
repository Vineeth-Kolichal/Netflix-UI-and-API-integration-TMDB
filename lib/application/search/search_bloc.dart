import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';
import 'package:netflix/domain/search/model/search_resp/search_resp.dart';
import 'package:netflix/domain/search/model/search_resp/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRrepo downloadService;
  final SearchService searchService;
  SearchBloc(this.downloadService, this.searchService)
      : super(SearchState.initial()) {
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(SearchState(
          searchResultList: [],
          idleList: state.idleList,
          isLoading: false,
          isError: false,
        ));
        return;
      }
      emit(const SearchState(
        searchResultList: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      //get trending
      final _result = await downloadService.getDownloadImages();
      final _state = _result.fold((MainFailure f) {
        return const SearchState(
          searchResultList: [],
          idleList: [],
          isLoading: false,
          isError: true,
        );
      }, (List<Downloads> list) {
        return SearchState(
          searchResultList: [],
          idleList: list,
          isLoading: false,
          isError: false,
        );
      });
      //show to ui
      emit(_state);
    });
    on<SearchMovie>((event, emit) async {
//call search movie
      emit(const SearchState(
        searchResultList: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      final result =
          await searchService.searchMovies(movieQuery: event.movieQuery);
      final _state = result.fold((l) {
        return SearchState(
          searchResultList: [],
          idleList: [],
          isLoading: false,
          isError: false,
        );
      }, (r) {
        return SearchState(
          searchResultList: r.results,
          idleList: [],
          isLoading: false,
          isError: false,
        );
      });
//show to ui
      emit(_state);
    });
  }
}
