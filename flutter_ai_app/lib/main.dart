import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter AI App',
      home: const AIChatPage(),
    );
  }
}

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final TextEditingController _controller = TextEditingController();
  String userText = '';
  String aiResponse = 'Hello! I am your AI assistant.';

  void getAIResponse() {
    setState(() {
      userText = _controller.text.toLowerCase();

      if (userText.contains('hello')) {
        aiResponse = 'Hello! How can I help you?';
      } else if (userText.contains('flutter')) {
        aiResponse = 'Flutter is used to build Android, iOS, and Web apps.';
      } else if (userText.contains('ai')) {
        aiResponse = 'AI means Artificial Intelligence.';
      } else if (userText.contains('bye')) {
        aiResponse = 'Goodbye! Have a nice day.';
      } else {
        aiResponse = 'Sorry, I did not understand that.';
      }

      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter AI Chat App'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              aiResponse,
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ask something',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: getAIResponse,
              child: const Text('Ask AI'),
            ),
          ],
        ),
      ),
    );
  }
}
