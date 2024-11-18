import 'package:doctor_appointment_app/utils/constant/image_constant.dart';
import 'package:doctor_appointment_app/utils/themes/color_themes.dart';
import 'package:doctor_appointment_app/utils/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  // Dummy data for chat list
  final List<Map<String, dynamic>> chatList = [
    {
      "name": "John Doe",
      "lastMessage": "Hey, how's it going?",
      "profileImage": ImageConstant.doctorImage1,
      "time": "12:30 PM"
    },
    {
      "name": "Alice Smith",
      "lastMessage": "Let's meet tomorrow.",
      "profileImage": ImageConstant.doctorImage2,
      "time": "11:15 AM"
    },
    {
      "name": "Dr. Sarah Johnson",
      "lastMessage": "Your appointment is confirmed.",
      "profileImage": ImageConstant.doctorImage3,
      "time": "9:45 AM"
    },
    // Add more chat data
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: customTextWidget(
            text: "Chat",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          final chat = chatList[index];

          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(chat[
                  'profileImage']), // Use NetworkImage if fetching from the web
            ),
            title: Text(
              chat['name'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              chat['lastMessage'],
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis, // Limit the last message to one line
            ),
            trailing: Text(
              chat['time'],
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            onTap: () {
              // Handle chat item tap
              // Navigate to chat details or chat messages screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(chat['name']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final String chatName;

  ChatDetailScreen(this.chatName);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {
      "text": "Hello! How can I help you?",
      "isSentByUser": false,
      "time": "10:00 AM"
    },
    {
      "text": "I have a question about my appointment.",
      "isSentByUser": true,
      "time": "10:02 AM"
    },
    {
      "text": "Sure, let me check that for you.",
      "isSentByUser": false,
      "time": "10:03 AM"
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      final newMessage = {
        "text": _messageController.text.trim(),
        "isSentByUser": true,
        "time": TimeOfDay.now().format(context),
      };

      setState(() {
        messages.add(newMessage);
      });

      // Clear the text field after sending
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatName),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['isSentByUser'];
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.all(10.0),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                        bottomLeft:
                            isUser ? const Radius.circular(10.0) : Radius.zero,
                        bottomRight:
                            isUser ? Radius.zero : const Radius.circular(10.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['text'],
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          message['time'],
                          style: TextStyle(
                            color: isUser ? Colors.white70 : Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Message Input Bar
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15.0),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send, color: Colors.blueAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
