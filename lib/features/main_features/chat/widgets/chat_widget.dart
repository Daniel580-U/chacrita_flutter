import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dotAnimation;

  @override
  void initState() {
    super.initState();
    // Configura el AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(); // Repite la animación continuamente

    // Define una animación de ciclo para los puntos (0 a 3)
    _dotAnimation = IntTween(begin: 0, end: 3).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _dotAnimation,
      builder: (context, child) {
        // Genera los puntos dinámicamente
        String dots = '.' * _dotAnimation.value;
        return Text(
          "Escribiendo$dots",
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        );
      },
    );
  }
}
