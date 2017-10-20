import 'dart:convert';

import 'package:flutter/services.dart';
import 'dart:async';

class WeatherAPI {
  String apiKey;
  var httpClient;

  WeatherAPI(String key) {
    apiKey = key;
    httpClient = createHttpClient();
  }

  Future<Map> getWeather(num latitude, num longitude) async {
   var response = await httpClient.read("https://api.darksky.net/forecast/$apiKey/$latitude,$longitude");

   return JSON.decode(response);
  }
}