import 'package:flutter/cupertino.dart';
import 'package:mentz_app_challenge/data/repository/search_repository.dart';
import 'package:mentz_app_challenge/domain/location_entity.dart';

class SearchUseCase {
  final SearchRepository searchRepository;

  SearchUseCase({
    required this.searchRepository
  });

  Future<List<LocationEntity>> search(String searchText) async {
    final searchResults = await searchRepository.getSearchResults(searchText);
    if (searchResults == null) {
      throw Exception("Could not get search results.");
    }
    debugPrint("Search Results: $searchResults");
    return searchResults;
  }
}
