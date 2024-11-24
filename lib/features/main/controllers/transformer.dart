class Converter {
  String summarize(
      Map<String, dynamic>? weather,
      Map<String, dynamic>? forecast,
      Map<String, dynamic>? airPollution
      )
  {
    String summary = '';
    String weatherSummary = summarizeWeather(weather);
    String forecastSummary = summarizeForecast(forecast);
    String airPollutionSummary = summarizeAirPollution(airPollution);

    if (weatherSummary.isNotEmpty){
      summary += 'Clima: \n$weatherSummary\n\n';
    }
    if (forecastSummary.isNotEmpty){
      summary += 'Pronóstico: \n$forecastSummary\n\n';
    }
    if (airPollutionSummary.isNotEmpty){
      summary += 'Contaminación: \n$airPollutionSummary';
    }

    return summary;
  }

  String summarizeWeather(Map<String, dynamic>? weatherData) {
    if (weatherData == null) {
      return 'No weather data available.';
    }

    final location = weatherData['name'] ?? 'Unknown location';
    final description = weatherData['weather']?[0]?['description'] ?? 'No description';
    final temp = weatherData['main']?['temp']?.toDouble();
    final feelsLike = weatherData['main']?['feels_like']?.toDouble();
    final humidity = weatherData['main']?['humidity']?.toInt();
    final pressure = weatherData['main']?['pressure']?.toInt();
    final windSpeed = weatherData['wind']?['speed']?.toDouble();

    return 'Weather summary for $location:\n'
        '- Condition: ${description[0].toUpperCase()}${description.substring(1)}\n'
        '- Temperature: ${temp?.toStringAsFixed(1)}°K\n'
        '- Feels like: ${feelsLike?.toStringAsFixed(1)}°K\n'
        '- Humidity: $humidity%\n'
        '- Pressure: $pressure hPa\n'
        '- Wind speed: ${windSpeed?.toStringAsFixed(1)} m/s';
  }

  String summarizeForecast(Map<String, dynamic>? forecastData) {
    if (forecastData == null) {
      return 'No forecast data available.';
    }

    final cityName = forecastData['city']?['name'] ?? 'Unknown city';
    final country = forecastData['city']?['country'] ?? 'Unknown country';

    final forecastList = forecastData['list'] as List<dynamic>? ?? [];

    if (forecastList.isEmpty) {
      return 'No forecast data available.';
    }

    String summary = 'Weather forecast for $cityName, $country:\n';

    for (final forecast in forecastList) {
      final dateTime = forecast['dt_txt'] as String?;
      final description = forecast['weather']?[0]?['description'] ?? 'No description';
      final temp = forecast['main']?['temp']?.toDouble();
      final tempMin = forecast['main']?['temp_min']?.toDouble();
      final tempMax = forecast['main']?['temp_max']?.toDouble();
      final pop = forecast['pop']?.toDouble();
      final windSpeed = forecast['wind']?['speed']?.toDouble();

      summary += 'Date and time: $dateTime\n'
          '- Condition: ${description[0].toUpperCase()}${description.substring(1)}\n'
          '- Temperature: ${temp?.toStringAsFixed(1)}°K\n'
          '- Temp range: ${tempMin?.toStringAsFixed(1)}°K - ${tempMax?.toStringAsFixed(1)}°K\n'
          '- Precipitation chance: ${(pop * 100)?.toStringAsFixed(0)}%\n'
          '- Wind speed: ${windSpeed?.toStringAsFixed(1)} m/s';

      // Getting just the first forecast
      break;
    }

    return summary;
  }

  String summarizeAirPollution(Map<String, dynamic>? airPollutionData) {
    if (airPollutionData == null) {
      return 'No air pollution data available.';
    }

    final location = airPollutionData['coord'] != null
        ? 'Location: (${airPollutionData['coord']['lat']}, ${airPollutionData['coord']['lon']})'
        : 'Unknown location';

    final pollutionList = airPollutionData['list'] as List<dynamic>? ?? [];

    if (pollutionList.isEmpty) {
      return '$location\nNo pollution data available.';
    }

    final pollutionData = pollutionList[0];
    final aqi = pollutionData['main']?['aqi']?.toInt();
    final aqiDescription = getAqiDescription(aqi);
    final components = pollutionData['components'] as Map<String, dynamic>? ?? {};

    return '$location\n'
        'Air Quality Index (AQI): $aqi ($aqiDescription)\n'
        '- CO (Carbon Monoxide): ${_getComponentAsDouble(components, 'co')?.toStringAsFixed(2)} µg/m³\n'
        '- NO (Nitric Oxide): ${_getComponentAsDouble(components, 'no')?.toStringAsFixed(3)} µg/m³\n'
        '- NO₂ (Nitrogen Dioxide): ${_getComponentAsDouble(components, 'no2')?.toStringAsFixed(3)} µg/m³\n'
        '- O₃ (Ozone): ${_getComponentAsDouble(components, 'o3')?.toStringAsFixed(2)} µg/m³\n'
        '- SO₂ (Sulfur Dioxide): ${_getComponentAsDouble(components, 'so2')?.toStringAsFixed(3)} µg/m³\n'
        '- PM2.5 (Fine Particles): ${_getComponentAsDouble(components, 'pm2_5')?.toStringAsFixed(1)} µg/m³\n'
        '- PM10 (Coarse Particles): ${_getComponentAsDouble(components, 'pm10')?.toStringAsFixed(3)} µg/m³\n'
        '- NH₃ (Ammonia): ${_getComponentAsDouble(components, 'nh3')?.toStringAsFixed(3)} µg/m³';
  }

  double? _getComponentAsDouble(Map<String, dynamic>? components, String component) {
    var value = components?[component];
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    }
    return null;
  }

  String getAqiDescription(int aqi) {
    switch (aqi) {
      case 1:
        return 'Good';
      case 2:
        return 'Fair';
      case 3:
        return 'Moderate';
      case 4:
        return 'Poor';
      case 5:
        return 'Very Poor';
      default:
        return 'Unknown';
    }
  }
}