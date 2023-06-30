import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meteo/model/city.dart';
import 'package:meteo/model/weather.dart';

Future<Weather> getWeather(City city) async {
  try {
    final dio = Dio();

    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        'lat': city.latitude.toString(),
        'lon': city.longitude.toString(),
        'appid': dotenv.env['METEO_API_KEY'],
      },
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  } catch (e) {
    print(e);
    rethrow;
  }
}
