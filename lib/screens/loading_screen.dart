import 'dart:convert';

import 'package:clima/models/weather_model.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/current_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String apiKey = '9860ad09fd0c5c0eacb90ea9114c5cdc';

  Future<void> getCurrenLocation() async {
    try {
      Position position = await Location().getCurrentLocation();

      String url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric';

      NetworkHelper networkHelper = NetworkHelper(url: url);

      try {
        http.Response response = await networkHelper.fetchData();
        Weather weather = Weather.fromJson(jsonDecode(response.body));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationScreen(weather: weather),
          ),
        );
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrenLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRipple(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
