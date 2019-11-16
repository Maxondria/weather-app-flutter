import 'package:clima/models/weather_model.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String apiKey = '9860ad09fd0c5c0eacb90ea9114c5cdc';

  Future<void> getCurrenLocation() async {
    try {
      WeatherModel weatherModel = WeatherModel();
      Weather weather = await weatherModel.getLocationData();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(weather: weather),
        ),
      );
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
