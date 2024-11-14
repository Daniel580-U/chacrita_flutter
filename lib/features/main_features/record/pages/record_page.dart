import 'dart:io';

import 'package:chacrita/features/main_features/record/controllers/record_controller.dart';
import 'package:chacrita/features/main_features/record/services/record_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: const Text('record Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_resultText),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _identifyPlant,
              child: const Text('Identificar Planta'),
            ),
          ],
        ),
      ),
    );
  }
}