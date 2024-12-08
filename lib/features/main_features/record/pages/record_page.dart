
import 'dart:io';

import 'package:chacrita/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:chacrita/features/main_features/record/services/record_service.dart';
import 'package:provider/provider.dart';


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
  }
  Future<void> _checkCameraPermission(BuildContext context) async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      // Solicita permiso si está denegado
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      // Si el permiso es concedido, abre la cámara
      _takePicture(context);
      
      if(_image != null) {
        
      }else{
        print("No se ha capturado ninguna foto");
      }
    } else {
      // Muestra mensaje si el permiso es denegado
      Navigator.of(context).pop('/main');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de cámara denegado')),
      );
    }
  }
  Future<void> _takePicture(BuildContext context) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    final GlobalState globalState = Provider.of<GlobalState>(context, listen: false);
    if (photo != null) {
      setState(() {
        _image = photo;
      });
      Map<String,dynamic>? apiPhoto= await RecordService().identifyPlant(File(_image!.path));
        if(apiPhoto != null){
          globalState.updateApiPhoto(apiPhoto);
        }
      Navigator.of(context).pop('/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    if(_image == null) _checkCameraPermission(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Captura de Foto')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                Center(child: CircularProgressIndicator()),

            const SizedBox(height: 20),
            ],
        ),
      ),
    );
  }
}