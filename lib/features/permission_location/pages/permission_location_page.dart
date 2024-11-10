import 'package:chacrita/features/index/pages/index_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionPage extends StatefulWidget {
  const LocationPermissionPage({super.key});

  @override
  _LocationPermissionPageState createState() =>
      _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage> {
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => const IndexPage()));
    } else if (status.isDenied) {
      // Si el permiso es denegado, muestra un mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission is required!')),
      );
    } else if (status.isPermanentlyDenied) {
      // Si el permiso es permanentemente denegado, redirige al usuario a la configuración
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Permission')),
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
