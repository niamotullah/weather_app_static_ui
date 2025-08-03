import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_static_ui/provider/current_weather_provider.dart';
import 'package:weather_app_static_ui/screens/main_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(),
      ),
      home: ChangeNotifierProvider(
        create: (context) => CurrentWeatherProvider(),
        child: MainScreen(),
      ),
    );
  }
}
