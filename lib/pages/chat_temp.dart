import 'package:flutter/material.dart';

import 'class_profile.dart';

class ChatTemp extends StatefulWidget {
  const ChatTemp({super.key});

  @override
  State<ChatTemp> createState() => _ChatTempState();
}

class _ChatTempState extends State<ChatTemp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const ClassBackDetail()));
          },
          child: const Text('go'),
        ),
      ),
    );
  }
}
