import 'services/weather_service_dio.dart';

void main() async {
  try {
    final weather = await fetchWeatherWithDio('Bangkok');
    print('✅ สำเร็จ (ดึงข้อมูลด้วย Dio)!');
    print('cityName: ${weather.cityName}');
    print('temperature: ${weather.temperature}');
    print('description: ${weather.description}');
    print('feelsLike: ${weather.feelsLike}');
  } catch (e) {
    print('❌ Error: $e');
  }
}