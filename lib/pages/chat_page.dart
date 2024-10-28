import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/CartItem.dart';
import '../models/cart.dart';
import '../models/catalog.dart';
import '../widgets/typing_indicator.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final List<ChatMessage> _messages = [];
  var _isSomeoneTyping = false;
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late var data;
  late List<CartItem> items;

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
    data = await fetchData(message);
    if (data != null && data.isNotEmpty) {
      if (data[1] == "end") {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('CONFIRM ORDER'),
                  content:
                      const Text('Are you sure you want to confirm order?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        confirmOrder(data[0]);
                        // Navigator.pushNamed(context, MyRoutes.cartPageRoute);
                        Navigator.pop(context,'OK');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ));
      } else {
        setState(() {
          _isSomeoneTyping = false;
          _messages.add(
              ChatMessage(sender: 'Assistant', text: data[0], isSender: false));
        });
      }
    }
    _scrollToBottom();
  }

  Future<void> confirmOrder(String req) async {
    try {
      final BASE = await dotenv.env['CONFIRM_API'];
      var url = BASE.toString();
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"orderStatement": req}),
      );
      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);
        var apiItems = resBody["items"];
        items = List.from(apiItems)
            .map<CartItem>((item) => CartItem.fromJson(item))
            .toList();
        items.forEach((element) async {
          await AddMutation(CatalogueModel().getById(element.itemId), q: element.quantity);
        });
        await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('ORDER CONFIRMED'),
              // content: const Text('Are you sure you want to confirm order?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context,'OK');
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
        Navigator.pushNamed(context, MyRoutes.cartPageRoute);
      } else {
        print('Error while confirming : ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Assistant')
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
                return ChatMessageBubble(
                    message: _messages[_messages.length - 1 - index]);
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
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              minLines: 1,
              onSubmitted: (text){
                _sendMessage;
              },
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
                hintText: 'Say Hii',
                hoverColor: Colors.amberAccent,
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
            ),
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
      padding: isSender ? EdgeInsets.fromLTRB(20, 2.5, 0, 2.5) : EdgeInsets.fromLTRB(0, 2.5, 20, 2.5),
      // padding: const EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment: isSender ? Alignment.bottomRight : Alignment.bottomLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: isSender ? Colors.blueAccent : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: isSender ? Radius.circular(12) : Radius.circular(0),
              bottomRight: isSender ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(message.sender,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSender ? Colors.white : Colors.black)),
              const SizedBox(height: 5),
              Text(
                message.text,
                style: TextStyle(color: isSender ? Colors.white : Colors.black),
              ),
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

  ChatMessage(
      {required this.sender, required this.text, required this.isSender});
}
