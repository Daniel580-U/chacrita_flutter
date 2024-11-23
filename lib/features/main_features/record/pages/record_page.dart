
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  _CaptureScreenState createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<RecordPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }
  Future<void> _checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      // Solicita permiso si está denegado
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      // Si el permiso es concedido, abre la cámara
      _takePicture();
    } else {
      // Muestra mensaje si el permiso es denegado
      Navigator.of(context).pop('/main');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de cámara denegado')),
      );
    }
  }

  Future<void> _takePicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _image = photo;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Captura de Foto')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Text("No se ha capturado ninguna foto")
                : Image.file(File(_image!.path)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkCameraPermission,
              child: const Text("Tomar Foto"),
            ),
          ],
        ),
      ),
    );
  }
}