import "dart:async";
import 'package:flutter/foundation.dart';
import 'package:mentz_app_challenge/data/http/search_http.dart';
import 'package:mentz_app_challenge/domain/location_entity.dart';


class SearchRepository {
  final SearchHttp httpSource = SearchHttp();

  Future<List<LocationEntity>?> getSearchResults(String searchText) async {
    try {
      final searchResults = await httpSource.getSearchResults(searchText);
      return searchResults;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
