// ignore_for_file: avoid_print

import 'package:dart_extensions/dart_extensions.dart';
import 'package:weather_app_static_ui/services/weather_response.dart';

/// Access current weather data for any location on Earth!
///
/// We collect and process weather data from different sources such as global and local weather models, satellites, radars and a vast network of weather stations
///
/// Data is available in JSON, XML, or HTML format.

class CurrentWeather {
  WeatherResponse? _data;
  DistanceUnit distanceUnit = DistanceUnit.meter;
  factory CurrentWeather.fromWeatherResponse(WeatherResponse response) {
    return CurrentWeather._(response);
  }

  CurrentWeather._(this._data);

  String? get base => _data?.base;
  Coord? get coord => _data?.coord;
  Main? get main => _data?.main;
  List<WeatherModel>? get weather => _data?.weather;
  Sys? get sys => _data?.sys;
  int? get timezone => _data?.timezone;
  int? get id => _data?.id;
  String? get name => _data?.name;
  int? get cod => _data?.cod;
  Wind? get wind => _data?.wind;
  Rain? get rain => _data?.rain;
  Clouds? get clouds => _data?.clouds;
  DateTime? get calculationTime {
    final secondsSinceEpoch = _data?.dt;
    return secondsSinceEpoch != null
        ? DateTimeExtensions.fromSecondsSinceEpoch(secondsSinceEpoch)
        : null;
  }

  num? visibility({DistanceUnit? distanceUnit}) {
    final visibilityInMeter = _data?.visibility;
    return switch (distanceUnit ?? this.distanceUnit) {
      DistanceUnit.meter => visibilityInMeter,
      DistanceUnit.kilometer =>
        visibilityInMeter != null ? visibilityInMeter / 1000.0 : null,
      DistanceUnit.miles =>
        visibilityInMeter != null ? visibilityInMeter / 1609.344 : null,
      DistanceUnit.nauticalMiles =>
        visibilityInMeter != null ? visibilityInMeter / 1852.0 : null,
    };
  }
}

enum DistanceUnit {
  meter,
  kilometer,
  miles,
  nauticalMiles,
}
