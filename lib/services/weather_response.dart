import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class Clouds {
  /// Cloudiness, %
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

/// Longitude and Latitude of the location
@JsonSerializable()
class Coord {
  ///[coord.lon] Longitude of the location
  final double lon;

  /// [coord.lat] Latitude of the location
  final double lat;

  Coord({required this.lon, required this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
class Main {
  final double? temp;
  @JsonKey(name: 'feels_like')
  final double? feelsLike;
  @JsonKey(name: 'temp_min')
  final double? tempMin;
  @JsonKey(name: 'temp_max')
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  @JsonKey(name: 'sea_level')
  final int? seaLevel;
  @JsonKey(name: 'grnd_level')
  final int? grndLevel;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  Map<String, dynamic> toJson() => _$MainToJson(this);
}

@JsonSerializable()
class Rain {
  @JsonKey(name: '1h')
  final double? oneHour;
  @JsonKey(name: '3h')
  final double? threeHours;

  Rain({this.oneHour, this.threeHours});

  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);

  Map<String, dynamic> toJson() => _$RainToJson(this);
}

@JsonSerializable()
class Sys {
  final int? type;
  final int? id;
  @JsonKey(name: 'country')
  final String? countryCode;
  final int? sunrise;
  final int? sunset;

  String? get country {
    if (countryCode == null) return null;

    return countryCode;
  }

  Sys({
    this.type,
    this.id,
    this.countryCode,
    this.sunrise,
    this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}

@JsonSerializable()
///[more info Weather condition codes](https://openweathermap.org/weather-conditions)
class WeatherModel {
  /// Weather condition id
  final int id;

  /// Group of weather parameters (Rain, Snow, Clouds etc.)
  final String main;

  /// Weather condition within the group. Please find more here. You can get the output in your language. Learn more
  final String description;

  /// Weather icon id
  final String icon;

  WeatherModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}

@JsonSerializable()
class WeatherResponse {
  final Coord coord;
  final List<WeatherModel>? weather;
  final String? base;
  @JsonKey(name: 'main')
  final Main? main;

  /// Visibility in meters
  ///
  /// Max value is 10,000 meters
  final int? visibility;
  final Wind? wind;
  final Rain? rain;
  final Clouds? clouds;

  /// Time of data calculation, unix, UTC
  final int? dt;
  final Sys? sys;

  /// timezone Shift in seconds from UTC
  final int? timezone;

  /// City ID. Please note that built-in geocoder functionality has been deprecated.
  ///
  /// Learn more [here](https://openweathermap.org/current#builtin)
  final int id;
  final String name;

  /// Internal parameter
  final int cod;

  WeatherResponse({
    this.main,
    required this.coord,
    this.weather,
    this.base,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

@JsonSerializable()
class Wind {
  final double speed;
  final int deg;
  final double? gust;

  Wind({required this.speed, required this.deg, this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}
