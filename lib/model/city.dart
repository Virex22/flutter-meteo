class City {
  final String name;
  final double latitude;
  final double longitude;
  final String country;
  final int population;
  final bool isCapital;

  City({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.population,
    required this.isCapital,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      country: json['country'],
      population: json['population'],
      isCapital: json['is_capital'],
    );
  }
}
