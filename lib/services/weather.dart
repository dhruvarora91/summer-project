import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';
import 'package:weather_app/components/weather_icon_mapper.dart';

const apiKey = '20d81477c63e1efb16ec0728cb7b9207';

class WeatherModel {
  Future getCityWeather(String cityName) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    var url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future getCityForecast(String cityName) async {
    var url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationForecast() async {
    Location location = Location();
    await location.getCurrentLocation();
    var url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}

IconData getIconData(iconCode) {
  switch (iconCode) {
    case '01d':
      return WeatherIcons.clear_day;
    case '01n':
      return WeatherIcons.clear_night;
    case '02d':
      return WeatherIcons.few_clouds_day;
    case '02n':
      return WeatherIcons.few_clouds_day;
    case '03d':
    case '04d':
      return WeatherIcons.clouds_day;
    case '03n':
    case '04n':
      return WeatherIcons.clear_night;
    case '09d':
      return WeatherIcons.shower_rain_day;
    case '09n':
      return WeatherIcons.shower_rain_night;
    case '10d':
      return WeatherIcons.rain_day;
    case '10n':
      return WeatherIcons.rain_night;
    case '11d':
      return WeatherIcons.thunder_storm_day;
    case '11n':
      return WeatherIcons.thunder_storm_night;
    case '13d':
      return WeatherIcons.snow_day;
    case '13n':
      return WeatherIcons.snow_night;
    case '50d':
      return WeatherIcons.mist_day;
    case '50n':
      return WeatherIcons.mist_night;
    default:
      return WeatherIcons.clear_day;
  }
}
