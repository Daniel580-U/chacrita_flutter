import 'package:flutter/material.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('record Page'),
      ),
      body: Center(
        child: Text('Bienvenido a record'),
      ),
    );
  }
}
