import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_static_ui/model/weather.dart';

final kClient = Dio(
  BaseOptions(
    baseUrl: 'https://api.openweathermap.org',
    queryParameters: {
      'appid': dotenv.get('owmApiKey'),
    },
  ),
);

class OpenWeatherMapServices {
  static late final Dio _owmClient;
  static OpenWeatherMapServices? _instance;
  OpenWeatherMapServices._() {
    _owmClient = kClient;
  }

  static OpenWeatherMapServices initialize() {
    return _instance ??= OpenWeatherMapServices._();
  }

  static OpenWeatherMapServices get instance =>
      _instance ??= OpenWeatherMapServices._();

  /// get [current] weather using latlon
  ///
  /// [Read more](https://openweathermap.org/current)
  // TODO
  Future<WeatherResponse> currentWeatherFromCoord(Coord coord) async {
    final lon = coord.lon;
    final lat = coord.lat;

    final Map<String, dynamic> response = await _owmClient
        .get(
          '/data/2.5/weather',
          queryParameters: {'lat': lat, 'lon': lon},
        )
        .then(
          (value) => value.data,
        );

    return WeatherResponse.fromJson(response);
  }
}
