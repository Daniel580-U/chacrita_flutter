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
              'What can I help you with?',
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
    {
      'text':
          "Hello. Chakrita is a mobile application that help farmers make smarter decisions, optimize their resources, and most importantly, protect their production against climate challenges. This application is not just a tool, it's an ally for agricultural sustainability.",
      'sender': 'bot',
    },
  ];
  final TextEditingController _textController = TextEditingController(text: "");

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
                    border: isUser ? Border.all(color: const Color.fromRGBO(0, 122, 27, 0.83)) : null,
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
                  controller: _textController,      
                  decoration: InputDecoration(
                    hintText: "Write a message...",
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
                icon: const Icon(Icons.send, color: Color.fromRGBO(0, 122, 27, 0.83)),
                onPressed: () {
                  
                  if(newMessage.isEmpty) return;

                  _textController.clear();
                  setState(() {
                    // Action to change state of variable newMessage
                    messages.add({'text':  newMessage, 'sender': 'user'});
                    //Action to call an API and process the message
                    processMessage(newMessage);

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
  
  void processMessage(String newMessage) {
    print(newMessage);
  }
}
