import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meteo/api_helper/city_api_helper.dart';
import 'package:meteo/api_helper/weather_api_helper.dart';
import 'package:meteo/model/city.dart';
import 'package:meteo/model/weather.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  WeatherPageState createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  Weather? _weather;

  bool _show = false;

  Future<Weather> getCityAndWeather(String cityName) async {
    try {
      final City city = await getCity(cityName);

      final Weather weather = await getWeather(city);

      return weather;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> _getWeatherData(String cityName) async {
    final Weather weather = await getCityAndWeather(cityName);

    setState(() {
      _weather = weather;
      _show = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _getWeatherData(_cityController.text),
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 16.0),
            _show
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City: ${_weather!.cityName}',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Country: ${_weather!.country}',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Temperature: ${_weather!.temperature.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
