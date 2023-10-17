
import 'package:mentz_app_challenge/domain/location_entity.dart';

enum SearchStatus {initial, search, success, failure, none}

class HomeScreenState {
  final List<LocationEntity> result;
  final SearchStatus status;
  final LocationEntity? chosenLocation;

  HomeScreenState({
    required this.result,
    required this.status,
    required this.chosenLocation,
  });

  factory HomeScreenState.initial() {
    return HomeScreenState(
      result: [],
      status: SearchStatus.initial,
      chosenLocation: null,
    );
  }

  HomeScreenState copyWith({
    List<LocationEntity>? result,
    SearchStatus? status,
    LocationEntity? chosenLocation,
  }) {
    return HomeScreenState(
      result: result ?? this.result,
      status: status ?? this.status,
        chosenLocation: chosenLocation ?? this.chosenLocation,
    );
  }
}
