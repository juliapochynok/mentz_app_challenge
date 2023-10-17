import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentz_app_challenge/data/repository/search_repository.dart';
import 'package:mentz_app_challenge/domain/location_entity.dart';
import 'package:mentz_app_challenge/domain/search_use_case.dart';
import 'package:mentz_app_challenge/main.dart';

import 'home_screen_event.dart';
import 'home_screen_state.dart';


class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  late final SearchUseCase searchUseCase;

  HomeScreenBloc() : super(
      HomeScreenState.initial()
  ) {
    searchUseCase = SearchUseCase(
        searchRepository: SearchRepository()
    );
    on<InitEvent>(_onInitialLoad);
    on<SearchEvent>(_onSearchEvent);
    on<LikeEvent>(_onLikeEvent);
    on<UnlikeEvent>(_onUnlikeEvent);
  }


  _onInitialLoad(InitEvent event, Emitter<HomeScreenState> emit) async {
    try {
      final result = await sharedPrefsLocalStorage.get("chosenLocation");
      if (result != null) {
        LocationEntity? chosenLocation = LocationEntity.fromSavedJson(result);
        emit(state.copyWith(status: SearchStatus.success, chosenLocation: chosenLocation));
      } else {
        emit(state.copyWith(
            status: SearchStatus.initial, chosenLocation: null));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: SearchStatus.failure));
    }
  }

  _onSearchEvent(SearchEvent event, Emitter<HomeScreenState> emit) async {
    try {
      if (event.searchText == "") {
        emit(state.copyWith(result: [], status: SearchStatus.search));
      } else {
        List<LocationEntity> result = await searchUseCase.search(
            event.searchText);
        emit(state.copyWith(result: result, status: SearchStatus.search));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(result: [], status: SearchStatus.failure));
    }
  }

  _onLikeEvent(LikeEvent event, Emitter<HomeScreenState> emit) async {
    try {
      sharedPrefsLocalStorage.save("chosenLocation", event.item.toJson());
      emit(state.copyWith(status: SearchStatus.success, chosenLocation: event.item));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: SearchStatus.failure));
    }
  }

  _onUnlikeEvent(UnlikeEvent event, Emitter<HomeScreenState> emit) async {
    try {
      sharedPrefsLocalStorage.clearAll();
      if (state.status == SearchStatus.search) {
        emit(HomeScreenState(result: state.result, status: SearchStatus.search, chosenLocation: null));
      } else {
        emit(HomeScreenState.initial());
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: SearchStatus.failure));
    }
  }
}
