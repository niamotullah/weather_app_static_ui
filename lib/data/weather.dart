import 'package:weather_app_static_ui/services/weather_response.dart';

final weatherLocationData = <WeatherLocationModel>[
  WeatherLocationModel(Coord(lat: 40.7128, lon: -74.0060)),
  WeatherLocationModel(Coord(lat: 51.5074, lon: -0.1278)),
  WeatherLocationModel(Coord(lat: 35.6762, lon: 139.6503)),
  WeatherLocationModel(Coord(lat: -33.8688, lon: 151.2093)),
];

class WeatherLocationModel {
  Coord coord;
  WeatherLocationModel(this.coord);
}
