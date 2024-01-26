import 'clouds.dart';

import 'coord.dart';
import 'sys.dart';
import 'weather.dart';
import 'wind.dart';

class WeatherData {
  final String? cod;
  final int? message;
  final int? cnt;
  final List<WeatherEntry>? list;
  final City? city;

  WeatherData({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    List<WeatherEntry> weatherEntries = List<WeatherEntry>.from(
        (json['list'] as List).map((entry) => WeatherEntry.fromJson(entry)));

    return WeatherData(
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list: weatherEntries,
      city: City.fromJson(json['city']),
    );
  }
}

class WeatherEntry {
  int dt;
  Main main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  Sys sys;
  String dtTxt;

  WeatherEntry({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory WeatherEntry.fromJson(Map<String, dynamic> json) {
    List<Weather> weatherList = List<Weather>.from(
        (json['weather'] as List).map((w) => Weather.fromJson(w)));

    return WeatherEntry(
      dt: json['dt'],
      main: Main.fromJson(json['main']),
      weather: weatherList,
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: json['pop'].toDouble(),
      sys: Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
    );
  }
  void forEach(void Function(String key, dynamic value) action) {
    action('dt', dt);
    action('main', main);
    action('weather', weather);
    action('clouds', clouds);
    action('wind', wind);
    action('visibility', visibility);
    action('pop', pop);
    action('sys', sys);
    action('dtTxt', dtTxt);
  }
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf'].toDouble(),
    );
  }
}

class City {
  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Coord.fromJson(json['coord']),
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}
