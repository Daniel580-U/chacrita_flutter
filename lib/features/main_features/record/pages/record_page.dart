import 'dart:io';

import 'package:chacrita/features/main_features/record/controllers/record_controller.dart';
import 'package:chacrita/features/main_features/record/services/record_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class RecordPage extends StatefulWidget {
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
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final RecordService _recordService = RecordService();
  final RecordController _recordController = RecordController();
  String _resultText = 'Bienvenido a record';

  Future<void> _identifyPlant() async {
    final byteData = await rootBundle.load('assets/img/plant.jpg');
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/plant.jpg');
    await tempFile.writeAsBytes(byteData.buffer.asUint8List());
    final result = await _recordService.identifyPlant(tempFile);

    // Updating result state
    setState(() {
      _resultText = result != null ? result.toString() : 'Identificación fallida';
    });
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