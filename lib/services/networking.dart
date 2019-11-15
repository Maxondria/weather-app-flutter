import 'dart:convert';

import 'package:clima/models/weather_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final longitude;
  final latitude;
  String apiKey = '9860ad09fd0c5c0eacb90ea9114c5cdc';

  NetworkHelper({@required this.latitude, @required this.longitude});

  Future<Weather> fetchData() async {
    Weather info;
    try {
      String url =
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        info = Weather.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      throw e.toString();
    }
    return info;
  }
}
