import '../controller/apiRepo.dart';
import '../model/current_day_weather.dart';

class GetWeather {
  final String city;
  final double lat;
  final double lon;
  static String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static String apiKey = 'appid=b347143483a20046211c2580993df19f';

  GetWeather({required this.city, required this.lat, required this.lon});

  Future<dynamic> getCurrentWeatherData() async {
    var url;
    if (city != '') {
      url = '$baseUrl/weather?q=$city&lang=en&$apiKey';
    } else {
      url = '$baseUrl/weather?lat=$lat&lon=$lon&lang=en&$apiKey';
    }

    try {
      dynamic data = await ApiRepo(url: url).get();
      return data;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> getFiveDaysWeather() async {
    var url;
    if (city != '') {
      url = '$baseUrl/forecast?q=$city&lang=en&$apiKey';
    } else {
      url = '$baseUrl/forecast?lat=$lat&lon=$lon&lang=en&$apiKey';
    }

    try {
      dynamic data = await ApiRepo(url: url).get();
      return data;
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
//CurrentWeatherData.fromJson(data)
