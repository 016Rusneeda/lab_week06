import 'package:dio/dio.dart';
import '../models/weather.dart';

Future<Weather> fetchWeatherWithDio(String city) async {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  try {
    // สังเกตว่า dio คืนค่ามาเป็น Map ให้อัตโนมัติ ไม่ต้องใช้ jsonDecode() 
    // และใส่ Query Parameters เป็น Map ได้เลยไม่ต้องต่อ String เอง
    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {'q': city, 'appid': 'YOUR_API_KEY', 'units': 'metric'}, // อย่าลืมแก้ YOUR_API_KEY
    );
    return Weather.fromJson(response.data as Map<String, dynamic>);
    
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      throw Exception('การเชื่อมต่อหมดเวลา กรุณาลองใหม่อีกครั้ง');
    } else if (e.type == DioExceptionType.badResponse) {
      throw Exception('เซิร์ฟเวอร์ตอบกลับผิดพลาด (${e.response?.statusCode})');
    } 
    // โค้ดที่เพิ่มใหม่สำหรับ Checkpoint 5.3
    else if (e.type == DioExceptionType.receiveTimeout) {
      throw Exception('เซิร์ฟเวอร์ใช้เวลาตอบกลับนานเกินไป');
    } else if (e.type == DioExceptionType.connectionError) {
      throw Exception('ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้');
    }
    
    throw Exception('เกิดข้อผิดพลาด: ${e.message}');
  }
}