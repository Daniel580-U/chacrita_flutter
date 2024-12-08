import 'package:chacrita/features/main/pages/main_page.dart';
import 'package:chacrita/features/main/services/geo_service.dart';
import 'package:chacrita/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:chacrita/features/main/controllers/geolocator_controller.dart';

class LocationPermissionPage extends StatefulWidget {
  const LocationPermissionPage({super.key});

  @override
  _LocationPermissionPageState createState() => _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage> {
  bool _isPermissionGranted = false;
  Map <String, dynamic>? apiWeather;
  Map <String, dynamic>? apiForecast;
  Map <String, dynamic>? apiAirPollution;
  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    // Solicitar permiso de ubicación
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // Si el permiso es concedido, navega a la siguiente pantalla
      GeolocatorController().getCurrentLocation().then((position) async{
        if (position != null) {
          double lat = position.latitude;
          double lon = position.longitude;

          // Open weather experiment
          String? weatherApiUrl = dotenv.env['OPEN_WEATHER_WEATHER_ENDPOINT'];
          String? forecastApiUrl = dotenv.env['OPEN_WEATHER_FORECAST_ENDPOINT'];
          String? airPollutionApiUrl = dotenv.env['OPEN_WEATHER_AIR_POLLUTION_ENDPOINT'];
          apiWeather= await GeoService().getApiRequest(lat, lon, weatherApiUrl);
          apiForecast= await GeoService().getApiRequest(lat, lon,forecastApiUrl);
          apiAirPollution= await GeoService().getApiRequest(lat, lon, airPollutionApiUrl);
          
          
        }
      });
      setState(() {
        _isPermissionGranted = true;
      });
    } else if (status.isDenied) {
      // Si el permiso es denegado, muestra un mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission is required!')),
      );
      Navigator.pop(context, '/guide');
      //Navigator.popAndPushNamed(context,'/guide'); 
    } else if (status.isPermanentlyDenied) {
      // Si el permiso es permanentemente denegado, redirige al usuario a la configuración
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);
    if (_isPermissionGranted) {
      if (globalState.apiWeather == null && apiWeather != null) {
        globalState.updateApiWeather(apiWeather!);
      } else {
        print('Error: No se pudo obtener la información del clima');
      }
      if (globalState.apiForecast == null && apiForecast != null) {
        globalState.updateApiForecast(apiForecast!);
      } else {
        print('Error: No se pudo obtener la información del pronóstico');
      }
      if (globalState.apiAirPollution == null && apiAirPollution != null) {
        globalState.updateApiAirPollution(apiAirPollution!);
      } else {
        print('Error: No se pudo obtener la información de la contaminación del aire');
      }
      
      return const MainPage();
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'We need your location permission to continue.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _requestLocationPermission,
                child: const Text('Grant Permission'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
