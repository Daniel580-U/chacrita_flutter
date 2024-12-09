import 'package:chacrita/app/config/colors.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/background_img.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    "CHAKRITA",
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'RubikGlitch',
                        letterSpacing: 0.6,
                        color: Colors.white),
                    selectionColor: Colors.white,
                  ),
                  const SizedBox(height: 15),
                  Image.asset(
                    'assets/img/chacrita_white.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ) // 20% de la altura
          ,
          ClipPath(
            // Clipper para crear la curvatura
            child: Container(
                height: MediaQuery.of(context).size.height *
                    0.55, // 80% de la altura
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/guide');
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              //color: Colors.green, // Fondo del círculo
                              border: Border.all(
                                  color: AppColors.primary, width: 2), // Borde verde
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.arrow_back, // Icono de flecha
                              color: AppColors.primary, // Color del ícono
                            ), /*const Icon(Icons.arrow_back, color: AppColors.primary, size: 20,)),*/
                          ),
                        ),
                      ],
                    ),
                    

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            maximumSize:
                                const WidgetStatePropertyAll(Size(400, 170)),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            backgroundColor:
                                const WidgetStatePropertyAll(Colors.blue),
                            padding: const WidgetStatePropertyAll(
                                EdgeInsets.fromLTRB(80,10,80,0)),
                            
                          ),
                          onPressed: () {
                            // Acción del botón 1
                            Navigator.of(context).pushNamed('/record');
                          },
                          child: Column(
                            children: [
                              //Insert Image
                              
                              const Text(
                                "CAMARA",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontFamily: 'NerkoOne'),
                              ),Image.asset('assets/img/camera.png',
                                  width: 100, height: 100),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                            maximumSize:
                                const WidgetStatePropertyAll(Size(300, 170)),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            backgroundColor:
                                const WidgetStatePropertyAll(Colors.redAccent),
                            padding: const WidgetStatePropertyAll(
                                EdgeInsets.fromLTRB(80,0,80,0)),
                          ),
                          onPressed: () {
                            // Acción del botón 2

                            Navigator.of(context).pushNamed('/chat');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              
                              const Text(
                                "CHAT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontFamily: 'NerkoOne'),
                              ),Image.asset('assets/img/chat.png',
                                  width: 110, height: 110),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),

          // Parte blanca con el ListView y la curvatura
        ],
      ),
    );
  }
}
