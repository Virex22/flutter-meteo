// from openweathermap.org

class Weather {
  String cityName;
  String country;
  double temperature;

  Weather({
    required this.cityName,
    required this.country,
    required this.temperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      country: json['sys']['country'],
      temperature: json['main']['temp'] - 273.15,
    );
  }
}
