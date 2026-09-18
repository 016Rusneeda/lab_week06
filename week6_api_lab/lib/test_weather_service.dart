import 'services/weather_service.dart';

void main() async {
  final service = WeatherService();

  print('กำลังดึงข้อมูลสภาพอากาศ...');

  try {
    // 1. ทดสอบกรณีเมืองมีอยู่จริง
    final weather = await service.fetchWeather('Bangkok');
    print('✅ สำเร็จ!');
    print('เมือง: ${weather.cityName}');
    print('อุณหภูมิ: ${weather.temperature}°C');
    print('รายละเอียด: ${weather.description}');
    
    // 2. ทดสอบกรณี Error หาเมืองไม่เจอ (ลบคอมเมนต์บรรทัดล่างเพื่อทดสอบ)
    await service.fetchWeather('Kmitl888');

  } catch (e) {
    print('404 Not Found : ไม่พบข้อมูลเมืองที่คุณค้นหา');
    print(e);
  }
}