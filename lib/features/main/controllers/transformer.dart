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
      return 'No hay data disponible sobre el clima.';
    }

    final location = weatherData['name'] ?? 'Posición desconocida';
    final description = weatherData['weather']?[0]?['description'] ?? 'No hay descripción';
    final temp = weatherData['main']?['temp']?.toDouble();
    final feelsLike = weatherData['main']?['feels_like']?.toDouble();
    final humidity = weatherData['main']?['humidity']?.toInt();
    final pressure = weatherData['main']?['pressure']?.toInt();
    final windSpeed = weatherData['wind']?['speed']?.toDouble();

    return 'Resumen del clima para $location:\n'
        '- Condición: ${description[0].toUpperCase()}${description.substring(1)}\n'
        '- Temperatura: ${temp?.toStringAsFixed(1)}°K\n'
        '- Sensación térmica: ${feelsLike?.toStringAsFixed(1)}°K\n'
        '- Humedad: $humidity%\n'
        '- Presión: $pressure hPa\n'
        '- Velocidad del viento: ${windSpeed?.toStringAsFixed(1)} m/s';
  }

  String summarizeForecast(Map<String, dynamic>? forecastData) {
    if (forecastData == null) {
      return 'No hay data disponible sobre el pronóstico.';
    }

    final cityName = forecastData['city']?['name'] ?? 'Ciudad desconocida';
    final country = forecastData['city']?['country'] ?? 'País desconocido';

    final forecastList = forecastData['list'] as List<dynamic>? ?? [];

    if (forecastList.isEmpty) {
      return 'No hay data disponible sobre el pronóstico.';
    }

    String summary = 'Pronóstico del clima para $cityName, $country:\n';

    for (final forecast in forecastList) {
      final dateTime = forecast['dt_txt'] as String?;
      final description = forecast['weather']?[0]?['description'] ?? 'No hay descripción';
      final temp = forecast['main']?['temp']?.toDouble();
      final tempMin = forecast['main']?['temp_min']?.toDouble();
      final tempMax = forecast['main']?['temp_max']?.toDouble();
      final pop = forecast['pop']?.toDouble();
      final windSpeed = forecast['wind']?['speed']?.toDouble();

      summary += "Fecha y hora: $dateTime\n"
          "- Condición: ${description[0].toUpperCase()}${description.substring(1)}\n"
          "- Temperatura: ${temp?.toStringAsFixed(1)}°K\n"
          "- Rango de temperatura: ${tempMin?.toStringAsFixed(1)}°K - ${tempMax?.toStringAsFixed(1)}°K\n"
          "- Probabilidad de precipitación: ${(pop * 100)?.toStringAsFixed(0)}%\n"
          "- Velocidad del viento: ${windSpeed?.toStringAsFixed(1)} m/s";

      // Getting just the first forecast
      break;
    }

    return summary;
  }

  String summarizeAirPollution(Map<String, dynamic>? airPollutionData) {
    if (airPollutionData == null) {
      return 'No hay data disponible sobre la contaminación del aire.';
    }

    final location = airPollutionData['coord'] != null
        ? 'Location: (${airPollutionData['coord']['lat']}, ${airPollutionData['coord']['lon']})'
        : 'Ubicación desconocida';

    final pollutionList = airPollutionData['list'] as List<dynamic>? ?? [];

    if (pollutionList.isEmpty) {
      return '$location\nNo hay data disponible sobre la contaminación del aire.';
    }

    final pollutionData = pollutionList[0];
    final aqi = pollutionData['main']?['aqi']?.toInt();
    final aqiDescription = getAqiDescription(aqi);
    final components = pollutionData['components'] as Map<String, dynamic>? ?? {};

    return '$location\n'
        'Índice de Calidad del Aire (ICA): $aqi ($aqiDescription)\n'
        '- CO (Monóxido de Carbono): ${_getComponentAsDouble(components, 'co')?.toStringAsFixed(2)} µg/m³\n'
        '- NO (Óxido Nítrico): ${_getComponentAsDouble(components, 'no')?.toStringAsFixed(3)} µg/m³\n'
        '- NO₂ (Dióxido de Nitrógeno): ${_getComponentAsDouble(components, 'no2')?.toStringAsFixed(3)} µg/m³\n'
        '- O₃ (Ozono): ${_getComponentAsDouble(components, 'o3')?.toStringAsFixed(2)} µg/m³\n'
        '- SO₂ (Dióxido de Azufre): ${_getComponentAsDouble(components, 'so2')?.toStringAsFixed(3)} µg/m³\n'
        '- PM2.5 (Partículas Finas): ${_getComponentAsDouble(components, 'pm2_5')?.toStringAsFixed(1)} µg/m³\n'
        '- PM10 (Partículas Gruesas): ${_getComponentAsDouble(components, 'pm10')?.toStringAsFixed(3)} µg/m³\n'
        '- NH₃ (Amoníaco): ${_getComponentAsDouble(components, 'nh3')?.toStringAsFixed(3)} µg/m³';
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