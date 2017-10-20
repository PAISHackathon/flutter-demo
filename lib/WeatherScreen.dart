import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_flutter_app/LocationManager.dart';
import 'package:test_flutter_app/WeatherAPI.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherState createState() => new _WeatherState();
}

class _WeatherState extends State<WeatherScreen> {
  WeatherAPI weatherAPI = new WeatherAPI('33e3eb8531e3b8a1f45f8a86c9ce66bc');
  LocationManager locationManager = new LocationManager();

  String weather;

  @override
  void initState() {
    super.initState();

   weather = 'unknown';
  }

  Future<Null> updateWeather() async {


    var location = await locationManager.getLocation();
    var weatherData = await weatherAPI.getWeather(location["latitude"], location["longitude"]);

    setState(() {
      weather = weatherData["daily"]["summary"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container (
            child: new Text("Weather Forecast:",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                )
            )
        ),
        new Container (
            margin: new EdgeInsets.all(20.0),
            child: new Text(weather,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 20.0
                )
            )
        ),
        new RaisedButton(onPressed: () => updateWeather(), child: new Text("Update Weather"))
      ]
    );
  }
}
