class Weather{
  final String cityName;
  final double temperatures;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperatures,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      cityName: json['name'],
      temperatures: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}