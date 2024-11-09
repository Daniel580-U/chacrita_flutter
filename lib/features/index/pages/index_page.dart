import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('index Page'),
      ),
      body: Center(
        child: Text('Bienvenido a index'),
      ),
    );
  }
}
