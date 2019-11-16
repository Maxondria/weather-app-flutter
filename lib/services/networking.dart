import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper({@required this.url});

  Future<http.Response> fetchData() async {
    http.Response info;
    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        info = response;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      throw e.toString();
    }
    return info;
  }
}
