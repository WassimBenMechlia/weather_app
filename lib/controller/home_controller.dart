import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:weather_app/service/get_weather.dart';

import '../model/current_day_weather.dart';
import '../model/temp_data.dart';
import '../model/weather_forecast.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    initState();
    super.onInit();
  }

  void updateWeather() {
    initState();
  }

  void setCity(String newCity) {
    city.value = newCity;
    getForecastWeather();
    getCurrentWeatherData(); // Call the API when the city is updated
  }

  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  WeatherData forecastData = WeatherData();
  var current = true.obs;
  var forecast = true.obs;

  String backgroundImagePath = '';
  double lat = 0.0;
  double lon = 0.0;
  RxBool manualSearch = false.obs;

  late RxString city = ''.obs;
  String baselottieRoute = 'assets/lotties/';
  String lottiePath = '';
  String finalLottiePath = '';
  List<String> lottieIcons = [
    'clearmoon.json',
    'cloudy.json',
    'cloudymoon.json',
    'rain.json',
    'snow.json',
    'sunny.json',
  ];

  void selectDayNight(String icontype) {
    bool isNightTime = isNight(currentWeatherData.sys!.sunrise!.toInt(),
        currentWeatherData.sys!.sunset!.toInt());

    backgroundImagePath = isNightTime
        ? "assets/images/nightTime.png"
        : "assets/images/dayTime.png";

    if (isNightTime) {
      switch (icontype) {
        case "01n":
          lottiePath = "clearmoon.json";
          break;
        case "02n":
        case "03n":
        case "04n":
          lottiePath = "cloudymoon.json";
          break;
        case "09n":
        case "10n":
        case "11n":
          lottiePath = "rain.json";
          break;
        default:
          lottiePath = "snow.json";
      }
    } else {
      switch (icontype) {
        case "01d":
          lottiePath = "sunny.json";
          break;
        case "02d":
        case "03d":
        case "04d":
          lottiePath = "cloudy.json";
          break;
        case "09d":
        case "10d":
        case "11d":
          lottiePath = "rain.json";
          break;
        default:
          lottiePath = "snow.json";
      }
    }

    finalLottiePath = '$baselottieRoute$lottiePath';
  }

  bool isNight(int sunrise, int sunset) {
    DateTime now = DateTime.now();
    DateTime sunriseTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    DateTime sunsetTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
    return now.isBefore(sunriseTime) || now.isAfter(sunsetTime);
  }

  Future<void> initState() async {
    Position position = await _getCurrentposition();
    lat = position.latitude;
    lon = position.longitude;
    getForecastWeather();
    getCurrentWeatherData();
  }

  Future<Position> _getCurrentposition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("location is disabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getCurrentWeatherData() async {
    current(true);
    try {
      var data = await GetWeather(city: '${city}', lat: lat, lon: lon)
          .getCurrentWeatherData();
      currentWeatherData = CurrentWeatherData.fromJson(data);

      current(false);
      selectDayNight(currentWeatherData.weather![0].icon.toString());
      update();
    } on Exception catch (e) {
      current(false);
      print(e);
    }
  }

  Future<void> getForecastWeather() async {
    forecast(true);
    try {
      var data = await GetWeather(city: '${city}', lat: lat, lon: lon)
          .getFiveDaysWeather();
      forecastData = WeatherData.fromJson(data);
      calculateAverageTempByDay();
      resultList.forEach((element) {
        print(element.day);
        print(element.temp);
      });
      forecast(false);
      update();
    } on Exception catch (e) {
      forecast(false);
      print(e);
    }
  }

  List<TemperatureData> resultList = [];

  void calculateAverageTempByDay() {
    Map<String, List<double>> tempByDay = {};
    forecastData.list?.forEach((entry) {
      String date = DateFormat('EEEE').format(
        DateTime.fromMillisecondsSinceEpoch(entry.dt * 1000),
      );
      tempByDay.putIfAbsent(date, () => []).add(entry.main.temp);
    });

    tempByDay.forEach((day, tempList) {
      double averageTemp = tempList.reduce((a, b) => a + b) / tempList.length;
      double roundedAverageTemp = (averageTemp - 273.15).roundToDouble();
      resultList.add(TemperatureData(day, roundedAverageTemp));
    });
    update();
  }
}
