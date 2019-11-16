import 'package:clima/models/weather_model.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final Weather weather;

  const LocationScreen({Key key, @required this.weather}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temperature;
  String icon;
  String message;
  String city;
  Icon weatherIcon = Icon(
    Icons.near_me,
    size: 50.0,
  );

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> weatherData = {
      'temperature': widget.weather.temp.round(),
      'icon': weatherModel.getWeatherIcon(widget.weather.id.toInt()),
      'message': weatherModel.getMessage(widget.weather.temp.toInt()),
      'city': widget.weather.city
    };
    updateState(weatherData);
  }

  void updateState(Map<String, dynamic> weather) {
    setState(() {
      temperature = weather['temperature'];
      icon = weather['icon'];
      message = weather['message'];
      city = weather['city'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      try {
                        Weather weather = await weatherModel.getLocationData();

                        Map<String, dynamic> weatherData = {
                          'temperature': weather.temp.round(),
                          'icon':
                              weatherModel.getWeatherIcon(weather.id.toInt()),
                          'message':
                              weatherModel.getMessage(weather.temp.toInt()),
                          'city': weather.city
                        };
                        updateState(weatherData);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var nameInput = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );

                      if (nameInput != null) {
                        Weather weather =
                            await weatherModel.getCityWeather(nameInput);

                        Map<String, dynamic> weatherData = {
                          'temperature': weather.temp.round(),
                          'icon':
                              weatherModel.getWeatherIcon(weather.id.toInt()),
                          'message':
                              weatherModel.getMessage(weather.temp.toInt()),
                          'city': weather.city
                        };
                        updateState(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$icon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $city',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
