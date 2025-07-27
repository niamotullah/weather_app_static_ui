import 'package:flutter/material.dart';
import 'package:weather_app_static_ui/data/weather.dart';
import 'package:weather_app_static_ui/model/weather.dart';
import 'package:weather_app_static_ui/utils/owm_services.dart';

class CurrentWeatherProvider extends ChangeNotifier {
  List<CurrentWeather>? _currentWeatherDataList;
  CurrentWeatherProvider() {
    _loadSaved();
  }

  void _loadSaved() async {
    _currentWeatherDataList = await Future.wait(
      weatherLocationData.map(
        (wlmodel) async {
          final weatherResponse = await OpenWeatherMapServices.instance
              .currentWeatherFromCoord(
                wlmodel.coord,
              );
          // Convert WeatherResponse to CurrentWeather as needed
          return CurrentWeather.fromWeatherResponse(weatherResponse);
        },
      ),
    );

    notifyListeners();
  }

  int get itemCount => _currentWeatherDataList?.length ?? 0;

  CurrentWeather? weatherWithIndex(int index) {
    final length = _currentWeatherDataList?.length ?? 0;
    if (index < 0 || index >= length) {
      throw RangeError('Index out of range: $index');
    }
    return _currentWeatherDataList?[index];
  }

  List<CurrentWeather>? get currentWeatherList => _currentWeatherDataList;
}
