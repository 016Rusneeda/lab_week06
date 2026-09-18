class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final double feelsLike;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.feelsLike,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    // ดึงค่าจาก object ย่อย 'main'
    final main = json['main'] as Map<String, dynamic>;
    final temperature = (main['temp'] as num).toDouble();
    final feelsLike = (main['feels_like'] as num).toDouble();

    // ดึงค่าจาก array 'weather' ตำแหน่งแรก
    final weatherList = json['weather'] as List<dynamic>;
    final weatherItem = weatherList[0] as Map<String, dynamic>;
    final description = weatherItem['description'] as String;

    // ดึงชื่อเมืองจากระดับบนสุด
    final cityName = json['name'] as String;

    return Weather(
      cityName: cityName,
      temperature: temperature,
      description: description,
      feelsLike: feelsLike,
    );
  }
}