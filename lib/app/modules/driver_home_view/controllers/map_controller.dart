import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';


class AppMapController extends ChangeNotifier {
  LatLng _center = const LatLng(53.326314, -6.552276);
  double _zoom = 15.0;
  bool _isOnline = true;
  int _notificationCount = 12;
  List<LatLng> _taxiLocations = [
    const LatLng(53.326514, -6.552076),
    const LatLng(53.327514, -6.551076),
    const LatLng(53.325314, -6.553276),
    const LatLng(53.324314, -6.550276),
  ];

  LatLng get center => _center;
  double get zoom => _zoom;
  bool get isOnline => _isOnline;
  int get notificationCount => _notificationCount;
  List<LatLng> get taxiLocations => _taxiLocations;

  void setCenter(LatLng newCenter) {
    _center = newCenter;
    notifyListeners();
  }

  void setZoom(double newZoom) {
    _zoom = newZoom;
    notifyListeners();
  }

  void toggleOnline() {
    _isOnline = !_isOnline;
    notifyListeners();
  }

  void clearNotifications() {
    _notificationCount = 0;
    notifyListeners();
  }

  void addTaxiLocation(LatLng location) {
    _taxiLocations.add(location);
    notifyListeners();
  }

  void refreshTaxis() {
    // Simulate taxis moving to new locations
    _taxiLocations = _taxiLocations.map((location) {
      return LatLng(
        location.latitude + (0.001 * (Random().nextDouble() - 0.5)),
        location.longitude + (0.001 * (Random().nextDouble() - 0.5)),
      );
    }).toList();
    notifyListeners();
  }
}