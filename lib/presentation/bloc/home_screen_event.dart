import 'package:mentz_app_challenge/domain/location_entity.dart';

abstract class HomeScreenEvent {}

class InitEvent extends HomeScreenEvent {}

class LoadingEvent extends HomeScreenEvent {}

class SearchEvent extends HomeScreenEvent {
  final String searchText;

  SearchEvent({required this.searchText});
}

class LikeEvent extends HomeScreenEvent {
  final LocationEntity item;

  LikeEvent({required this.item});
}


class UnlikeEvent extends HomeScreenEvent {
  final LocationEntity item;

  UnlikeEvent({required this.item});
}