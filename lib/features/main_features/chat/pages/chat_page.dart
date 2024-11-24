import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundColor: Colors.green,
            child: Image.asset(
              'assets/img/chacrita_logo.png',
              width: 53,
              height: 54,
            ),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'ChatBot',
              style: TextStyle(
                fontFamily: 'Popins',
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '¿Tienes algo en mente? Estoy aquí para ayudarte.',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close,
                color: Color.fromRGBO(0, 122, 27, 0.83)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ChatBody(),
    );
  }
}

class ChatBody extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {
      'text':
          "Hola. Chakrita es una aplicación móvil que ayuda a los agricultores a tomar decisiones más inteligentes, optimizar sus recursos y, lo más importante, proteger su producción frente a los desafíos climáticos. Esta aplicación no es solo una herramienta, es un aliado para la sostenibilidad agrícola.",
      'sender': 'bot',
    },
    {
      'text':
          'Ya te envié las fotos de mi planta de tomate. ¿Qué me puedes decir sobre cómo cuidarla específicamente?',
      'sender': 'user',
    },
    {
      'text':
          '¡Claro! Aquí tienes algunos cuidados específicos para tu planta de tomate: Riego: Mantén el suelo húmedo, pero evita el encharcamiento. Los tomates necesitan riego constante, especialmente en climas cálidos. Luz solar: Coloca la planta en un lugar donde reciba al menos 6 horas de luz directa al día para favorecer un buen crecimiento. Nutrientes: Agrega fertilizantes ricos en potasio y fósforo para fortalecer la planta y mejorar la producción de frutos. Control de plagas: Observa regularmente las hojas y el tallo en busca de signos de plagas. Chakrita te enviará alertas sobre las plagas comunes en tu región. Protección contra el clima: Si se esperan condiciones climáticas adversas, como lluvias intensas o calor extremo, te notificaremos para que puedas tomar medidas, como resguardar o cubrir la planta.',
      'sender': 'bot',
    },
  ];


  ChatBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(16.0),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final isUser = message['sender'] == 'user';
              final left = isUser ? 100.0 : 0.0;
              final right = isUser ? 0.0 : 100.0;
              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  margin: EdgeInsets.fromLTRB(left, 4, right, 4),
                  decoration: BoxDecoration(
                    color: isUser
                        ? Colors.white
                        : const Color.fromRGBO(0, 122, 27, 0.83),
                    borderRadius: BorderRadius.only(
                      topLeft: isUser ? Radius.zero : const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: const Radius.circular(20),
                      bottomRight:
                          isUser ? const Radius.circular(20) : Radius.zero,
                    ),
                    border: isUser ? Border.all(color: Color.fromRGBO(0, 122, 27, 0.83)) : null,
                  ),
                  child: Text(
                    message['text']!,
                    style:
                        TextStyle(color: isUser ? Colors.black : Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  
                  backgroundColor: Color.fromRGBO(0, 122, 27, 0.83),
                  child: IconButton(              
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: () {
                      // Action to send the message
                    },
                  ),
                ),
              ),
              Expanded(
                
                child: TextField(               
                  decoration: InputDecoration(
                    hintText: "Escribe algo...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color.fromRGBO(0, 122, 27, 0.83)),
                onPressed: () {
                  // Action to send the message
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
