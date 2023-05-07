import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/hot_and_new%20_resp/hot_and_new_service.dart';
import 'package:netflix/domain/hot_and_new%20_resp/models/hot_and_new_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    on<LoadDataInComingSoon>((event, emit) async {
      //send loading to ui
      emit(const HotAndNewState(
          comingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          hasError: false));
      //get data from remote
      final _result = await _hotAndNewService.getHotAndNewMovieData();

      //data to state
      final newState = _result.fold((l) {
        return const HotAndNewState(
          comingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: false,
          hasError: true,
        );
      }, (r) {
        return HotAndNewState(
          comingSoonList: r.results,
          everyOneIsWatchingList: state.everyOneIsWatchingList,
          isLoading: false,
          hasError: false,
        );
      });
      emit(newState);
    });
    on<LoadDataInEveryoneIsWatching>((event, emit) async {
      emit(const HotAndNewState(
          comingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          hasError: false));
      //get data from remote
      final result = await _hotAndNewService.getHotAndNewTVData();
    
      //data to state
      final newState = result.fold((l) {
        return const HotAndNewState(
          comingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: false,
          hasError: true,
        );
      }, (r) {
        return HotAndNewState(
          comingSoonList: state.comingSoonList,
          everyOneIsWatchingList: r.results,
          isLoading: false,
          hasError: false,
        );
      });
      emit(newState);
    });
  }
}
