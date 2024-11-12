import 'package:chacrita/features/main_features/chat/pages/chat_page.dart';
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
                  const SizedBox(height: 100),
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
                  const SizedBox(height: 100),
                  Image.asset(
                    'assets/img/chacrita_logo.png',
                    width: 151,
                    height: 152,
                  ),
                ],
              ),
            ),
          ) // 20% de la altura
          ,
          ClipPath(
            // Clipper para crear la curvatura
            child: Container(
                height: MediaQuery.of(context).size.height *
                    0.4, // 80% de la altura
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      ),
                      onPressed: () {
                        // Acción del botón 1
                        print("Botón 1 presionado");
                      },
                      child: const Text(
                        "Recorder",
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 24,
                          fontFamily: 'NerkoOne'
                          ),
                      ),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.redAccent),
                      ),
                      onPressed: () {
                        // Acción del botón 2
                        
                      Navigator.push(context,MaterialPageRoute(builder: (context) => const ChatPage()));
                      },
                      child: const Text("Ask the chat",style: TextStyle(
                          color: Colors.white, 
                          fontSize: 24,
                          fontFamily: 'NerkoOne'
                          ),),
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
