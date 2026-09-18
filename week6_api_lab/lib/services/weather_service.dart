import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  // TODO: อย่าลืมเปลี่ยน YOUR_API_KEY เป็นคีย์จริงของคุณแบบเดียวกับที่ใส่ใน Postman
  static const _apiKey = 'cce3235279dab0c78de9d6a2fc80ee89';

  Future<Weather> fetchWeather(String city) async {
    final uri = Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric&lang=th');

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        // จัดการกรณี 404 หาเมืองไม่เจอ
        throw Exception('ไม่พบข้อมูลเมืองที่คุณค้นหา');
      }
      
      // กรณีสถานะอื่นๆ ที่ไม่ใช่ 200 หรือ 404
      throw Exception('เกิดข้อผิดพลาดจากเซิร์ฟเวอร์ (รหัส: ${response.statusCode})');

    } on TimeoutException {
      throw Exception('การเชื่อมต่อหมดเวลา กรุณาลองใหม่อีกครั้ง');
    } on http.ClientException {
      throw Exception('ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้ กรุณาตรวจสอบการเชื่อมต่อ');
    } on FormatException {
      // ดักจับกรณี JSON ผิดรูปแบบ
      throw Exception('ข้อมูลที่ได้รับจากเซิร์ฟเวอร์ผิดรูปแบบ ไม่สามารถอ่านค่าได้');
    } catch (e) {
      rethrow;
    }
  }
}