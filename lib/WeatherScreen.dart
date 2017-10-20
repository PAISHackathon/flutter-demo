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

  Map weather;

  @override
  void initState() {
    super.initState();
  }

  Future<Null> updateWeather() async {
    var location = await locationManager.getLocation();
    var weatherData = await weatherAPI.getWeather(location["latitude"], location["longitude"]);

    setState(() {
      weather = weatherData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
            appBar: new AppBar(
                leading: new IconButton(icon: new Icon(Icons.refresh), onPressed: () {
                  updateWeather();
                }),
                title: new Text('Current weather 2'),
                bottom: new TabBar(
                    tabs: [
                      new Tab(text: 'Current'),
                      new Tab(text: 'Hourly'),
                      new Tab(text: 'Daily')
                    ]
                )
            ),
            body: new TabBarView(
                children: [
                  _currentWeatherView(),
                  _listWeatherView(weather != null ? weather["hourly"]["data"] : null),
                  _listWeatherView(weather != null ? weather["daily"]["data"] : null)
                ]
            )
        )
    );
  }

  Widget _currentWeatherView() {
    var summary = weather != null ? weather["currently"]["summary"] : '';
    var temperature = weather != null ? weather["currently"]["temperature"] : '';
    var windSpeed = weather != null ? weather["currently"]["windSpeed"] : '';
    var humidity = weather != null ? weather["currently"]["humidity"] : '';

    return new Column(
      children: <Widget>[
        new Text(
            "Weather: $summary",
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 20.0
            )
        ),
        new Text(
            "Temperature: $temperature",
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 20.0
            )
        ),
        new Text(
            "Wind speed: $windSpeed",
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 20.0
            )
        ),
        new Text(
            "Humidity : $humidity",
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 20.0
            )
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center
    );
  }

  Widget _listWeatherView(List entries) {
    return new ListView.builder(
        itemCount: entries != null ? entries.length : 0,
        padding: new EdgeInsets.all(8.0),
        itemBuilder: (BuildContext context, int index) {
          var entry = entries[index];
          return new Container(
            padding: new EdgeInsets.all(10.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Text(new DateTime.fromMicrosecondsSinceEpoch(entry["time"] * 1000000, isUtc: true)
                    .toString()),
                new Text("Temperature: ${entry['temperature'] != null
                    ? entry['temperature']
                    : entry['temperatureMin']}"),
                new Text("Weather: ${entry['summary']}")
              ],
            ),
          );
        }
    );
  }

  //new RaisedButton(onPressed: () => updateWeather(), child: new Text("Update Weather"))
//              new Container (
//                  child: new Text("Weather Forecast:",
//                      textAlign: TextAlign.center,
//                      style: new TextStyle(
//                        fontSize: 30.0,
//                        fontWeight: FontWeight.bold,
//                      )
//                  )
//              ),
//              new Container (
//                  margin: new EdgeInsets.all(20.0),
//                  child: new Text(weather,
//                      textAlign: TextAlign.center,
//                      style: new TextStyle(
//                          fontSize: 20.0
//                      )
//                  )
//              ),
}
