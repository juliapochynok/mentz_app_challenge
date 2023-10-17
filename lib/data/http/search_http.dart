import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mentz_app_challenge/domain/location_entity.dart';

import '../api.dart';
import 'package:http/http.dart' as http;

class SearchHttp {
  Future<List<LocationEntity>> getSearchResults(String searchText) async {
    String url =
        "${Api.apiLink}/XML_STOPFINDER_REQUEST?language=de&outputFormat=RapidJSON&type_sf=any&name_sf=$searchText";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (json.isNotEmpty) {
        final List<LocationEntity> locations = (json["locations"] as Iterable)
            .map((model) => LocationEntity.fromJson(model))
            .toList();
        return locations;
      }

      return [];
    } else {
      debugPrint("ERROR SearchHttp - HTTP STATUS: ${response.statusCode}");
      return [];
    }
  }
}
