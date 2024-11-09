import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Parte transparente (superior 20%)
          Transform.rotate(
              angle: 3.14159 / 2,
              child: Transform.translate(
                  offset: Offset(-MediaQuery.of(context).size.height * 0.3, 0),
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/img/background_img.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Transform.rotate(
                          angle: -3.14159 / 2,
                          child: Transform.translate(
                            offset:  const Offset(0, -50),
                            child :const Text("CHAKRITA",
                              
                              style: TextStyle(
                                  
                                  fontSize: 45,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'RubikGlitch',
                                  letterSpacing: 0.6,
                                  color: Colors.white
                                ),
                              selectionColor: Colors.white, ),
                        ),
                      )))) )// 20% de la altura
          ,
          ClipPath(
            clipper: CurvedClipper(), // Clipper para crear la curvatura
            child: Container(
              height:
                  MediaQuery.of(context).size.height * 0.85, // 80% de la altura
              color: Colors.white,
              child: ListView.builder(
                itemCount: 5, // Número de elementos en el listado
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              ),
            ),
          ),

          // Parte blanca con el ListView y la curvatura
        ],
      ),
    );
  }
}

// CustomClipper para crear la curvatura
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Empieza en la esquina superior izquierda
    path.lineTo(0.0, 0.0);

    // Dibuja la curvatura, el control de la curva es ajustable
    path.quadraticBezierTo(
      size.width / 2, // El control de la curva (ajustable)
      size.height / 5, // Altura de la curva (ajustable)
      size.width, // Final en la esquina superior derecha
      0.0,
    );

    // Finaliza la parte inferior derecha y conecta con la parte inferior izquierda
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);

    // Cierra el camino de la forma
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // No necesitamos volver a recortar en este caso
  }
}
