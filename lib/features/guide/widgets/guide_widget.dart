import 'package:flutter/material.dart';

class GuideWidget extends StatelessWidget {
  const GuideWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Text('Este es un widget de guide'),
    );
  }
}
