import 'dart:convert';

import 'package:clima/utilities/current_location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> getCurrenLocation() async {
    try {
      Position position = await Location().getCurrentLocation();
      print(position);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrenLocation();
  }

  Future<http.Response> fetchData() async {
    const url =
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22';
    http.Response response = await http.get(url);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            try {
              http.Response response = await fetchData();

              if (response.statusCode == 200) {
                Weather info = Weather.fromJson(json.decode(response.body));
                print(info.id);
                print(info.main);
                print(info.description);
              }
            } catch (e) {
              print(e);
            }
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}

class Weather {
  final id;
  final main;
  final description;
  final icon;
  final name;
  final temp;
  final humidity;

  Weather(
      {this.id,
      this.name,
      this.description,
      this.humidity,
      this.icon,
      this.main,
      this.temp});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['weather'][0]['id'],
      name: json['name'],
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
      main: json['weather'][0]['main'],
      temp: json['main']['temp'],
    );
  }
}
