import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_static_ui/screens/search_location.dart';
import 'package:weather_app_static_ui/provider/current_weather_provider.dart';
import 'package:weather_app_static_ui/screens/weather_details_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
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
        builder: (context, provider, child) {
          return FutureBuilder(
            future: provider.init(),
            builder: (context, asyncSnapshot) {
              final isLoading =
                  asyncSnapshot.connectionState != ConnectionState.done;
              return isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: provider.itemCount,
                      itemBuilder: (context, index) {
                        Color weatherColor;
                        IconData weatherIcon;
                        final weatherType =
                            provider
                                .items[index]
                                .weather
                                ?.first // [first] since api returns a list
                                .main
                                .toLowerCase()
                                .trim() ??
                            'Unknown';

                        (weatherIcon, weatherColor) = switch (weatherType) {
                          'clear' => (Icons.wb_sunny, Colors.orange),
                          'clouds' => (Icons.cloud, Colors.blueGrey),
                          'rain' => (Icons.grain, Colors.blue),
                          'snow' => (Icons.ac_unit, Colors.lightBlueAccent),
                          _ => (Icons.wb_cloudy, Colors.grey),
                        };

                        return ExpansionTile(
                          backgroundColor:
                              Theme.of(
                                    context,
                                  )
                                  .colorScheme
                                  .primaryContainer, // TODO:  looks bad in dark-mode
                          leading: Icon(
                            weatherIcon,
                            color: weatherColor,
                          ),
                          title: Text(
                            provider.items[index].name ?? 'Unknown Location',
                          ),
                          subtitle: _weatherInfoSubtitleBuilder(
                            temperature:
                                provider.items[index].main?.temp ?? 0.0,
                            description:
                                provider
                                    .items[index]
                                    .weather
                                    ?.first
                                    .description ??
                                'Unknown',
                          ),
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WeatherDetailsScreen(
                                            weather: provider.weatherWithIndex(
                                              index,
                                            ),
                                          ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          'Humidity: ${provider.items[index].main?.humidity ?? 'Unknown'}%',
                                        ),
                                        subtitle: Text(
                                          'Wind: ${provider.items[index].wind?.speed ?? 'Unknown'} m/s',
                                        ),
                                      ),
                                    ),

                                    Align(
                                      alignment: Alignment.centerRight,

                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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

  Widget _weatherInfoSubtitleBuilder({
    double? temperature,
    String? description,
  }) {
    return Row(
      children: [
        Text(
          '${temperature?.toStringAsFixed(1) ?? "Unknown"}°C',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Text(
          description ?? "Unknown",
          style: TextStyle(color: Colors.black.withValues(alpha: 0.7)),
        ),
      ],
    );
  }
}
