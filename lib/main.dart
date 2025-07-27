import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_static_ui/provider/current_weather_provider.dart';
import 'package:weather_app_static_ui/utils/owm_services.dart';

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

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class SearchWeatherDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, 'return from close');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Return search results based on the query
    return Center(
      child: Text('Results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Return search suggestions
    return Center(
      child: Text('Suggestions for: $query'),
    );
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark().copyWith(brightness: Brightness.dark),
      ),
      home: ChangeNotifierProvider(
        create: (context) => CurrentWeatherProvider(),
        child: MainScreen(),
      ),
    );
  }
}

class WeatherInfoSubtitle extends StatelessWidget {
  final double temperature;
  final String description;

  const WeatherInfoSubtitle({
    super.key,
    required this.temperature,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // You can use localization here if needed
    return Row(
      children: [
        Text(
          '${temperature.toStringAsFixed(1)}°C',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Text(
          style: TextStyle(color: Colors.black.withValues(alpha: 0.7)),
          description,
        ),
      ],
    );
  }
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final actionButtons = [
      IconButton(
        //TODO
        onPressed: _addNewWeather,
        icon: Icon(Icons.add_location_alt_outlined),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: actionButtons,
      ),
      body: Consumer<CurrentWeatherProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.itemCount,
            itemBuilder: (context, index) {
              Color weatherColor;
              IconData weatherIcon;

              switch (value.currentWeatherList?[index].weatherDescription
                  .toLowerCase()
                  .trim()) {
                case 'clear':
                  weatherColor = Colors.orange;
                  weatherIcon = Icons.wb_sunny;
                  break;
                case 'clouds':
                  weatherColor = Colors.blueGrey;
                  weatherIcon = Icons.cloud;
                  break;
                case 'rain':
                  weatherColor = Colors.blue;
                  weatherIcon = Icons.grain;
                  break;
                case 'snow':
                  weatherColor = Colors.lightBlueAccent;
                  weatherIcon = Icons.ac_unit;
                  break;
                default:
                  weatherColor = Colors.grey;
                  weatherIcon = Icons.wb_cloudy;
              }

              return ExpansionTile(
                leading: Icon(
                  weatherIcon,
                  color: weatherColor,
                ),
                title: Text(
                  value.currentWeatherList?[index].name ?? 'Unknown Location',
                ),
                subtitle: WeatherInfoSubtitle(
                  temperature:
                      value.currentWeatherList?[index].temperature ?? 0.0,
                  description:
                      value.currentWeatherList?[index].weatherDescription ??
                      'Unknown',
                  // color: weatherColor.withOpacity(0.7),
                ),
                children: [
                  ListTile(
                    title: Text(
                      'Humidity: ${value.currentWeatherList?[index].humidity ?? 'Unknown'}%',
                    ),
                    subtitle: Text(
                      'Wind: ${value.currentWeatherList?[index].windSpeed ?? 'Unknown'} m/s',
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _addNewWeather() async {
    await showSearch(
      context: context,
      delegate: SearchWeatherDelegate(),
    );
  }
}
