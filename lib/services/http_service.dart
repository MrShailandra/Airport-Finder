import 'dart:io';
import 'package:airport_finder/models/airports_list.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class HttpService {
  getdata() async {
    var url = Uri.parse(
        "https://raw.githubusercontent.com/mwgg/Airports/master/airports.json");
    http.Response response = await http.get(url);

    var responseData = response.body;
    var airportD = airportDataFromJson(responseData);
    List<AirportData> airportData = [];

    airportD.entries.forEach((e) => airportData.add(AirportData(
          name: e.value.name,
          icao: e.value.icao,
          city: e.value.city,
          state: e.value.state,
          country: e.value.country,
          elevation: e.value.elevation,
          lat: e.value.lat,
          lon: e.value.lon,
          tz: e.value.tz,
        )));
    print(airportData[0].name);

    return airportData;
  }

  Future readJson() async {
    var dir = await getExternalStorageDirectory();
    print(dir);
    File jsonFile = await File("${dir!.path}/country.json");
    var data = airportDataFromJson(jsonFile.readAsStringSync());
    List<AirportData> airportData = [];

    data.entries.forEach((e) => airportData.add(AirportData(
          name: e.value.name,
          icao: e.value.icao,
          city: e.value.city,
          state: e.value.state,
          country: e.value.country,
          elevation: e.value.elevation,
          lat: e.value.lat,
          lon: e.value.lon,
          tz: e.value.tz,
        )));
    print(airportData[0].name);
    return airportData;
  }
}
