import 'package:flutter/material.dart';

class RecordWidget extends StatelessWidget {
  const RecordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Text('Este es un widget de record'),
    );
  }
}
