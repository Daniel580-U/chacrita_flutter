import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  Map<String, dynamic>? _apiPhoto;
  Map<String, dynamic>? _apiWeather ;
  Map<String, dynamic>? _apiForecast;
  Map<String, dynamic>? _apiAirPollution;

  Map<String, dynamic>? get apiPhoto => _apiPhoto;
  Map<String, dynamic>? get apiWeather => _apiWeather ;
  Map<String, dynamic>? get apiForecast => _apiForecast;
  Map<String, dynamic>? get apiAirPollution => _apiAirPollution;

 //update
 void updateApiPhoto(Map<String, dynamic> apiPhoto) {
    _apiPhoto = apiPhoto;
    notifyListeners();
  }
  void updateApiWeather(Map<String, dynamic> apiWeather) {
    _apiWeather = apiWeather;
    notifyListeners();
  }
  void updateApiForecast(Map<String, dynamic> apiForecast) {
    _apiForecast = apiForecast;
    notifyListeners();
  }
  void updateApiAirPollution(Map<String, dynamic> apiAirPollution) {
    _apiAirPollution = apiAirPollution;
    notifyListeners();
  }
}
