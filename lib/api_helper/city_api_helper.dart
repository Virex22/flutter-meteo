import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meteo/model/city.dart';

Future<City> getCity(String cityName) async {
  final dio = Dio();

  final result = await dio.get(
    'https://api.api-ninjas.com/v1/city',
    queryParameters: {
      'name': cityName,
    },
    options: Options(
      headers: {
        'X-Api-Key': dotenv.env['CITY_API_KEY'],
      },
    ),
  );

  if (result.statusCode == 200) {
    return City.fromJson(result.data[0]);
  } else {
    throw Exception('Failed to fetch city data');
  }
}
