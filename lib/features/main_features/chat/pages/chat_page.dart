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
      body: ChatBody(),
    );
  }
}

class ChatBody extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {
      'text':
          "Hello. Chakrita is a mobile application that help farmers make smarter decisions, optimize their resources, and most importantly, protect their production against climate challenges. This application is not just a tool, it's an ally for agricultural sustainability.",
      'sender': 'bot',
    },
    {
      'text':
          'I already sent you the photos of my tomato plant. What can you tell me about how to take care of it specifically?',
      'sender': 'user',
    },
    {
      'text':
          'Of course! Here is some specific care for your tomato plant:irrigation: Keep the soil moist, but avoid waterlogging. Tomatoes need constant watering, especially in hot weather.Sunlight: Place the plant in a location where it receives at least 6 hours of direct light per day to promote good growth. Nutrients: Add fertilizers rich in potassium and phosphorus to strengthen the plant and improve fruit production. Pest Control: Observe the leaves and stem regularly for signs of pests. Chakrita will send you alerts about common pests in your region. Protection against the weather: If bad weather is expected, such as heavy rain or extreme heat, we will notify you so you can take measures, such as sheltering or covering the plant.',
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
                    hintText: "Write a message...",
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
