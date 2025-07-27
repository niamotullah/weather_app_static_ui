import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

class CurrentWeather {
  WeatherResponse? _data;
  CurrentWeather._(this._data);
  factory CurrentWeather.fromWeatherResponse(WeatherResponse response) =>
      CurrentWeather._(response);

  String get weatherDescription =>
      _data?.weather.first.description ?? 'Unknown';
  String get name => _data?.name ?? 'Unknown';
  double get temperature => _data?.main?.temp ?? 0; // Temperature in Kelvin
  double get feelsLike => _data?.main?.feelsLike ?? 0.0;
  double get tempMin => _data?.main?.tempMin ?? 0.0;
  double get tempMax => _data?.main?.tempMax ?? 0.0;
  int get humidity => _data?.main?.humidity ?? 0;
  double get windSpeed => _data?.wind?.speed ?? 0.0;
}

@JsonSerializable()
class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable()
class Coord {
  final double lon;
  final double lat;

  Coord({required this.lon, required this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);

  Map<String, dynamic> toJson() => _$CoordToJson(this);
}

@JsonSerializable()
class Main {
  final double temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  @JsonKey(name: 'temp_min')
  final double tempMin;
  @JsonKey(name: 'temp_max')
  final double tempMax;
  final int pressure;
  final int humidity;
  @JsonKey(name: 'sea_level')
  final int? seaLevel;
  @JsonKey(name: 'grnd_level')
  final int? grndLevel;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
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
  final String? country;
  final int sunrise;
  final int sunset;

  Sys({
    this.type,
    this.id,
    this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}

@JsonSerializable()
class _Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  _Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory _Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class WeatherResponse {
  final Coord? coord;
  final List<_Weather> weather;
  final String? base;
  final Main? main;
  final int? visibility;
  final Wind? wind;
  final Rain? rain;
  final Clouds? clouds;
  final int dt;
  final Sys? sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  WeatherResponse({
    this.coord,
    required this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    required this.dt,
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
