import 'package:chacrita/features/main/controllers/transformer.dart';
import 'package:chacrita/features/main_features/chat/widgets/chat_widget.dart';
import 'package:chacrita/features/main_features/record/controllers/record_transformer.dart';
import 'package:chacrita/provider.dart';
import 'package:flutter/material.dart';
import 'package:chacrita/app/config/colors.dart';
import 'package:chacrita/features/main_features/chat/services/chat_service.dart';
import 'package:provider/provider.dart';

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
          children: [
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
                color: AppColors.primary),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: const ChatBody(),
    );
  }
}

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});
  @override
  ChatBodyState createState() => ChatBodyState();
}
class ChatBodyState extends State<ChatBody> {
  String newMessage = '';
  final List<Map<String, String>> messages = [
    /*{
      'text':
          "Hola. Chakrita es una aplicación móvil que ayuda a los agricultores a tomar decisiones más inteligentes, optimizar sus recursos y, lo más importante, proteger su producción frente a los desafíos climáticos. Esta aplicación no es solo una herramienta, es un aliado para la sostenibilidad agrícola.",
      'sender': 'system',
    },*/
  ];
  final TextEditingController _textController = TextEditingController(text: "");
  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(16.0),
            itemCount: messages.length+(_isTyping?1:0),
            itemBuilder: (context, index) {
              if (index == messages.length && _isTyping) {
                return Align(
                alignment:
                     Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  margin: const EdgeInsets.fromLTRB(0.0, 4, 100, 4),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft:   Radius.circular(20),
                      topRight:  Radius.circular(20),
                      bottomLeft:  Radius.circular(20),
                      bottomRight:
                           Radius.zero,
                    ),
                    border:  null,
                  ),
                  child: TypingIndicator(),
                ),
              );
                
              }
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
                        ? AppColors.secondary
                        : AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: isUser ? Radius.zero : const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: const Radius.circular(20),
                      bottomRight:
                          isUser ? const Radius.circular(20) : Radius.zero,
                    ),
                    border: isUser ? Border.all(color: AppColors.secondary) : null,
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
                  
                  backgroundColor: AppColors.primary,
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
                  controller: _textController,      
                  decoration: InputDecoration(
                    hintText: "Escribe algo...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) => {
                    // Action to change state of variable newMessage
                    setState(() {
                       newMessage = value;
                    }),
                  },
                  
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: AppColors.primary),
                onPressed: () {
                  
                  if(newMessage=='') return;

                  _textController.clear();
                  setState(() {
                    // Action to change state of variable newMessage
                    messages.add({'text':  newMessage, 'sender': 'user'});
                    //Action to call an API and process the message
                    processMessage(newMessage,context);

                    newMessage = '';
                    
                  });
                  
                  // Action to send the message
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  void processMessage(String newMessage,BuildContext context) {
    setState(() {
      _isTyping = true;
    });
    //2 contextos
    final globalState = Provider.of<GlobalState>(context, listen: false);
    String summarizeWeather= (Converter().summarize(globalState.apiWeather, globalState.apiForecast, globalState.apiAirPollution));
    String summarizePlant= (RecordConverter().summarize(globalState.apiPhoto));
    //mensajes lista
    //mensaje
    ChatService().chat(newMessage, messages, summarizePlant+ "\n"+summarizeWeather).then((value) {
      if (value != null) {
        setState(() {
          messages.add({'text': value, 'sender': 'system'});
        });
      } else {
        setState(() {
          messages.add({'text': 'Lo siento, no puedo responder a esto. Por favor, haz otra pregunta.', 'sender': 'system'});
        });
      }
      setState(() {
      _isTyping = false;
    });
    });
  }
}
