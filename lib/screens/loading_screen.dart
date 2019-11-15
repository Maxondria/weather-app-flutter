import 'package:clima/models/weather_model.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/current_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  Future<void> getCurrenLocation() async {
    try {
      Position position = await Location().getCurrentLocation();
      latitude = position.latitude;
      longitude = position.longitude;

      NetworkHelper networkHelper =
          NetworkHelper(latitude: latitude, longitude: longitude);
      try {
        Weather weather = await networkHelper.fetchData();
        print(weather.name);
        print(weather.description);
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
        child: RaisedButton(
          onPressed: () {},
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
