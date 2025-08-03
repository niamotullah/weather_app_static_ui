import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_static_ui/services/owm_services.dart';
import 'package:weather_app_static_ui/weather_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load env
  await dotenv.load(fileName: '.env');

  OpenWeatherMapServices.initialize();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode && !(Platform.isAndroid || Platform.isIOS),
      builder: (context) => WeatherApp(),
    ),
  );
}
