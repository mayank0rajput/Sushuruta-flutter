import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../widgets/typing_indicator.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final List<ChatMessage> _messages = [ ];
  var _isSomeoneTyping = false;
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollToBottom); // Add scroll listener
  }

  @override
  void dispose() {
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Scrolls the chat to the bottom when a new message is added.
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        // Check if the user is near the bottom
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;

        // Scroll only if the user is near the bottom (e.g., within 100 pixels)
        if ((maxScroll - currentScroll) < 100) {
          _scrollController.animateTo(
            maxScroll,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  // Makes API call to fetch assistant's response
  static Future<List<String>?> fetchData(String req) async {
    try {
      final url = await dotenv.env['SERVER_URL'];
      final response = await http.post(
        Uri.parse(url!),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"userPrompt": req}),
      );

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        return [resBody['response'], resBody['status'].toString()];
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return null;
  }

  // Handles sending the user's message and fetching assistant's response
  Future<void> _sendMessage() async {
    final message = controller.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(sender: 'You', text: message, isSender: true));
      _isSomeoneTyping = true;
    });
    controller.clear(); // Clear input field

    // Fetch response from API
    final data = await fetchData(message);
    if (data != null && data.isNotEmpty) {
      setState(() {
        _isSomeoneTyping = false;
        _messages.add(ChatMessage(sender: 'Assistant', text: data[0], isSender: false));
      });
    }

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Row(
          children: const [
            Text('Assistant'),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatMessageBubble(message: _messages[_messages.length - 1 - index]);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: TypingIndicator(
              showIndicator: _isSomeoneTyping,
            ),
          ),
          _buildInputSection(),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.emoji_emotions), onPressed: () {}),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Message Assistant',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.camera_alt), onPressed: () {}),
          IconButton(icon: const Icon(Icons.mic), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isSender = message.isSender;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment: isSender ? Alignment.bottomRight : Alignment.bottomLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: isSender ? Colors.blue[200] : Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: isSender ? const Radius.circular(10) : Radius.zero,
              topRight: isSender ? Radius.zero : const Radius.circular(10),
              bottomLeft: const Radius.circular(10),
              bottomRight: const Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(message.sender, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(message.text),
            ],
          ),
        ),
      ),
    );
  }
}


class ChatMessage {
  final String sender;
  final String text;
  final bool isSender;

  ChatMessage({required this.sender, required this.text, required this.isSender});
}