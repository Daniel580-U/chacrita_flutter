import 'package:flutter/material.dart';
import 'package:chacrita/features/guide/models/guide_model.dart';

class GuideListWidget extends StatelessWidget {
  final int number;
  final String text;
  const GuideListWidget({
    super.key,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
              //padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
                boxShadow: const[
                  BoxShadow(
                    blurStyle: BlurStyle.normal,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(145, 199, 145,
                              0.29), // Fondo verde claro con opacidad
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: <Widget>[
                            const SizedBox(width: 15), // Espacio para el número
                            Expanded(
                              child: Center(
                                child: Text(
                                  GuideModel.guiderules[
                                      number - 1], // Texto del elemento
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Antic',
                                    fontSize: 14,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                            ),
                            // Número con fondo verde y forma circular
                          ],
                        ),
                      )))),
          Positioned(
            left: 25,
            top: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(30, 111, 0, 1),
                shape: BoxShape.circle, // Forma circular
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '$number', // Número como texto
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Abel',
                    color: Colors.white, // Texto blanco
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
