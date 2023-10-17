
class LocationEntity {
  final String id;
  final String name;
  final String disassembledName;
  final int matchQuality;
  final String type;
  final String subType;
  final double lat;
  final double lon;
  final String streetName;

  LocationEntity({
    required this.id,
    required this.name,
    required this.disassembledName,
    required this.matchQuality,
    required this.type,
    required this.subType,
    required this.lat,
    required this.lon,
    required this.streetName,
  });

  factory LocationEntity.fromJson(Map<String, dynamic> json) {
    final parent = json.containsKey("parent") ? json["parent"] : null;

    LocationEntity locationEntity = LocationEntity(
      id: json.containsKey("id") ? json["id"] as String : "",
      name: json.containsKey("name") ? json["name"] as String : "",
      disassembledName: json.containsKey("disassembledName")
          ? json["disassembledName"] as String
          : "",
      matchQuality:
          json.containsKey("matchQuality") ? json["matchQuality"] as int : -1,
      type: json.containsKey("type") ? json["type"] as String : "",
      subType: (parent != null && parent.containsKey("type"))
          ? parent["type"] as String
          : "",
      lat: json.containsKey("coord") ? json["coord"][0] : 0,
      lon: json.containsKey("coord") ? json["coord"][1] : 0,
      streetName:
          json.containsKey("streetName") ? json["streetName"] as String : "",
    );

    return locationEntity;
  }

  factory LocationEntity.fromSavedJson(Map<String, dynamic> json) {
    LocationEntity locationEntity = LocationEntity(
      id: json.containsKey("id") ? json["id"] as String : "",
      name: json.containsKey("name") ? json["name"] as String : "",
      disassembledName: json.containsKey("disassembledName")
          ? json["disassembledName"] as String
          : "",
      matchQuality:
      json.containsKey("matchQuality") ? int.parse(json["matchQuality"]) : -1,
      type: json.containsKey("type") ? json["type"] as String : "",
      subType: json.containsKey("subType")
          ? json["subType"] as String
          : "",
      lat: json.containsKey("lat") ? double.parse(json["lat"]) : 0,
      lon: json.containsKey("lon") ? double.parse(json["lon"]) : 0,
      streetName:
      json.containsKey("streetName") ? json["streetName"] as String : "",
    );

    return locationEntity;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "disassembledName": disassembledName,
      "matchQuality": matchQuality.toString(),
      "type": type,
      "subType": subType,
      "lat": lat.toString(),
      "lon": lon.toString(),
      "streetName": streetName,
    };
  }
}
