import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('guide Page'),
      ),
      body: Center(
        child: Text('Bienvenido a guide'),
      ),
    );
  }
}
