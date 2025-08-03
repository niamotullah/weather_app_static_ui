import 'package:flutter/material.dart';
import 'package:weather_app_static_ui/model/current_weather.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final CurrentWeather? weather;

  const WeatherDetailsScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    if (weather == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Weather Details')),
        body: Center(child: Text('No weather data available')),
      );
    }

    // todo: add more detailed weather information here
    // add more widgets to display detailed weather info
    // for example, hourly forecast, weekly forecast, etc.
    return Scaffold(
      appBar: AppBar(title: Text(weather?.name ?? 'Unknown Location')),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/${weather?.weather?.first.icon}@2x.png',
                  width: 64,
                  height: 64,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.wb_cloudy, size: 64),
                ),
                SizedBox(width: 16),
                Text(
                  '${weather?.main?.temp ?? 0.0}°C',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              weather?.name ?? 'Unknown Location',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.description, color: Colors.blueGrey),
                SizedBox(width: 8),
                Text(
                  '${weather!.weather?.first.main} - ${weather!.weather?.first.description}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: 16),
            SizedBox(height: 120, child: _hourlyForecast),
            SizedBox(height: 16),
            SizedBox(height: 200, child: _weeklyForecast),
            SizedBox(height: 16),

            Text('Feels Like: ${weather?.main?.feelsLike}°C'),
            Text('Min Temp: ${weather?.main?.tempMin}°C'),
            Text('Max Temp: ${weather?.main?.tempMax}°C'),
            Text('Pressure: ${weather?.main?.pressure} hPa'),
            Text('Humidity: ${weather?.main?.humidity}%'),
            Text('Sea Level: ${weather?.main?.seaLevel} hPa'),
            Text('Ground Level: ${weather?.main?.grndLevel} hPa'),
            Text(
              'Visibility: ${weather?.visibility(distanceUnit: DistanceUnit.kilometer)} km',
            ),
            Text('Wind Speed: ${weather?.wind?.speed} m/s'),
            Text('Wind Direction: ${weather?.wind?.deg}°'),
            Text('Wind Gust: ${weather?.wind?.gust} m/s'),
            SizedBox(height: 16),
            Text('Rain (1h): ${weather?.rain?.oneHour} mm'),
            SizedBox(height: 16),
            Text('Cloudiness: ${weather?.clouds?.all}%'),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  ListView get _weeklyForecast {
    return ListView.separated(
      itemCount: 7, // Example: 7 days
      separatorBuilder: (_, _) => Divider(),
      itemBuilder: (context, i) {
        //TODO: Placeholder weekly data
        final days = [
          'Mon',
          'Tue',
          'Wed',
          'Thu',
          'Fri',
          'Sat',
          'Sun',
        ];
        final temp = weather?.main?.temp;
        return ListTile(
          leading: Icon(Icons.wb_cloudy, color: Colors.blueGrey),
          title: Text(days[i]),
          trailing: Text('$temp°C'),
        );
      },
    );
  }

  ListView get _hourlyForecast {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 6, // Example: 6 hours
      separatorBuilder: (_, __) => SizedBox(width: 8),
      itemBuilder: (context, i) {
        // TODO: Placeholder hourly data
        final hour = 8 + i;
        final temp = weather?.main?.temp;
        return Container(
          width: 120,
          height: 120,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$hour:00',
                style: TextStyle(fontSize: 16),
              ),
              Icon(
                Icons.wb_sunny,
                color: Colors.orange,
              ),
              Text(
                '$temp°C',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
