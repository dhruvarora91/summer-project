import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/extraweatherinfo.dart';
import 'package:weather_app/components/infobox.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/components/forecastCard.dart';
import 'city_screen.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var weatherData, forecastData;
  @override
  void initState() {
    super.initState();

    getData();
    getDataUpdateUI();
  }

  var temperature,
      cityName,
      weatherType,
      maxTemp,
      minTemp,
      iconCode,
      icon,
      windSpeed,
      feelsLike,
      humidity;

  bool locationSign = false;
  String weatherIcon, weatherMsg;

  Future getData() async {
    WeatherModel weatherModel = WeatherModel();
    weatherData = await weatherModel.getLocationWeather();
    forecastData = await weatherModel.getLocationForecast();
    Map data = {
      'weather': weatherData,
      'forecast': forecastData,
    };

    return data;
  }

  void getCityWeather(cityName) async {
    if (cityName != null) {
      locationSign = false;
      WeatherModel weatherModel = WeatherModel();
      weatherData = await weatherModel.getCityWeather(cityName);
      forecastData = await weatherModel.getCityForecast(cityName);
      updateUI(weatherData: weatherData, forecastData: forecastData);
    }
  }

  void getDataUpdateUI() async {
    var data = await getData();
    var weatherData = data['weather'];

    locationSign = true;
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMsg = 'Unable to find location';
        cityName = '';
        weatherType = '';
        maxTemp = 0;
        minTemp = 0;
        iconCode = '';
        icon = getIconData(iconCode);
        windSpeed = 0;
        feelsLike = 0;
        humidity = 0;
      } else {
        cityName = weatherData['name'];
        temperature = weatherData['main']['temp'].toInt();
        weatherType = weatherData['weather'][0]['main'];
        maxTemp = weatherData['main']['temp_max'].toInt();
        minTemp = weatherData['main']['temp_min'].toInt();
        iconCode = weatherData['weather'][0]['icon'];
        icon = getIconData(iconCode);
        windSpeed = weatherData['wind']['speed'].toInt();
        feelsLike = weatherData['main']['feels_like'].toInt();
        humidity = weatherData['main']['humidity'].toInt();
      }
    });
  }

  void updateUI({weatherData, forecastData}) async {
    setState(() {
      if (weatherData == null || forecastData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMsg = 'Unable to find location';
        cityName = '';
        weatherType = '';
        maxTemp = 0;
        minTemp = 0;
        iconCode = '';
        icon = getIconData(iconCode);
        windSpeed = 0;
        feelsLike = 0;
        humidity = 0;
      } else {
        cityName = weatherData['name'];
        temperature = weatherData['main']['temp'].toInt();
        weatherType = weatherData['weather'][0]['main'];
        maxTemp = weatherData['main']['temp_max'].toInt();
        minTemp = weatherData['main']['temp_min'].toInt();
        iconCode = weatherData['weather'][0]['icon'];
        icon = getIconData(iconCode);
        windSpeed = weatherData['wind']['speed'].toInt();
        feelsLike = weatherData['main']['feels_like'].toInt();
        humidity = weatherData['main']['humidity'].toInt();
      }
    });
  }

  int getForecastDataLength(forecastdata) {
    return forecastData['list'].length;
  }

  Widget getForecastCard({forecastdata, index}) {
    return ForecastCard(
      date: forecastData['list'][index]['dt'],
      iconCode: forecastData['list'][index]['weather'][0]['icon'],
      temperature: forecastData['list'][index]['main']['temp'].toInt(),
      description: forecastData['list'][index]['weather'][0]['main'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return SafeArea(
            child: Scaffold(
              body: SpinKitFadingFour(
                color: Colors.black,
                size: 50.0,
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Color(0xFFE6E6E9),
            body: Container(
              constraints: BoxConstraints.expand(),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () async {
                            locationSign = true;

                            updateUI(
                              weatherData: snapshot.data['weather'],
                              forecastData: snapshot.data['forecast'],
                            );
                          },
                          child: Icon(
                            Icons.near_me,
                            size: 25.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$cityName ',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Visibility(
                              visible: locationSign,
                              child: Icon(
                                Icons.location_on,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                        FlatButton(
                          onPressed: () async {
                            var cityName = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CityScreen(),
                              ),
                            );

                            if (cityName != null) {
                              getCityWeather(cityName);
                            }
                          },
                          child: Icon(
                            Icons.location_city,
                            size: 25.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InfoBox(
                          color: Color(0xFF5773FE),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Icon(icon, size: 100.0),
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  Text(
                                    '$weatherType',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '$temperature°',
                                    style: TextStyle(fontSize: 75),
                                  ),
                                  Text(
                                    'Feels Like $feelsLike°',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        InfoBox(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WeatherMinorDetails(
                                  title: 'Wind Speed',
                                  value: '$windSpeed m/s',
                                ),
                                WeatherMinorDetails(
                                  title: 'Max',
                                  value: '$maxTemp°',
                                ),
                                WeatherMinorDetails(
                                  title: 'Min',
                                  value: '$minTemp°',
                                ),
                                WeatherMinorDetails(
                                  title: 'Humidity',
                                  value: humidity.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Last Updated: ',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              DateFormat('d MMMM yyyy, HH:mm')
                                  .format(DateTime.now()),
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 2.0,
                            color: Colors.black,
                            thickness: 2.0,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: getForecastDataLength(forecastData),
                        itemBuilder: (context, index) {
                          return getForecastCard(
                            forecastdata: snapshot.data['forecast'],
                            index: index,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
