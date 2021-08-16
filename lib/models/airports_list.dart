import 'dart:convert';

Map<String, AirportData> airportDataFromJson(String str) =>
    Map.from(json.decode(str)).map(
        (k, v) => MapEntry<String, AirportData>(k, AirportData.fromJson(v)));

String airportDataToJson(Map<String, AirportData> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class AirportData {
  AirportData({
    this.icao,
    this.name,
    this.city,
    this.state,
    this.country,
    this.elevation,
    this.lat,
    this.lon,
    this.tz,
  });

  String? icao;

  String? name;
  String? city;
  String? state;
  String? country;
  int? elevation;
  double? lat;
  double? lon;
  String? tz;

  factory AirportData.fromJson(Map<String, dynamic> json) => AirportData(
        icao: json["icao"],
        name: json["name"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        elevation: json["elevation"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        tz: json["tz"],
      );

  Map<String, dynamic> toJson() => {
        "icao": icao,
        "name": name,
        "city": city,
        "state": state,
        "country": country,
        "elevation": elevation,
        "lat": lat,
        "lon": lon,
        "tz": tz,
      };
}
