import 'package:dio/dio.dart';

import '../model/current_day_weather.dart';

class ApiRepo {
  final String url;

  Dio _dio = Dio();

  ApiRepo({required this.url});

  Future<dynamic> get() async {
    try {
      dynamic response = await _dio.get(
        url,
      );

      return response.data;
    } on Exception catch (e) {
      throw (e);
    }
  }

  Future<dynamic> getFiveDaysWeather() async {
    try {
      dynamic response = await _dio.get(
        url,
      );

      return response.data;
    } on Exception catch (e) {
      throw (e);
    }
  }
}
