import 'dart:async';
import 'package:location/location.dart';

class LocationManager {
  Location _location;

  LocationManager() {
    _location = new Location();
  }

  Future<Map<String,double>> getLocation() async {
    return await _location.getLocation;
  }

  void requestPermissions() {
    getLocation();
  }
}