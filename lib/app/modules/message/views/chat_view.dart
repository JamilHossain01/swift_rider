import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_ride/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';
import '../widgest/message_wigets.dart';

class ChatScreen extends StatefulWidget {

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 50),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.men1,
                        height: 50.0,
                        width: 50.0,
                      ),
                      SizedBox(width: 12.0), // Adjust spacing between icon and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Arlene McCoy',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          CustomText(
                            text: 'Online',
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset(
                    AppImages.calls,
                    height: 16.0,
                    width: 16.0,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // User's message (Text and Audio)
                    MessageWidget(
                      message: 'Have a great working week!!\nHope you like it',
                      audioDuration: '00:16',
                      isSender: true,
                      useNetworkImage: false,
                    ),
                    // Receiver's message (Text and Audio)
                    MessageWidget(
                      message: 'Thank you! Same to you!\nLooking forward to our project.',
                      audioDuration: '00:12',
                      isSender: false,
                      useNetworkImage: false,
                    ),
                    // User's message (Text and Audio)
                    MessageWidget(
                      message: 'Did you check the latest design files?',
                      audioDuration: '00:08',
                      isSender: true, useNetworkImage: false,
                    ),
                    // Receiver's message (Text and Audio)
                    MessageWidget(
                      message: 'Yes, they look great! I have some minor suggestions though.',
                      audioDuration: '00:15',
                      isSender: false, useNetworkImage: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Message input section
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Left smiley face icon
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Handle smiley face
                      print('Smiley icon pressed');
                    },
                    icon: Icon(Icons.sentiment_satisfied_alt),
                    iconSize: 24,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(width: 10),

                // The TextField for typing message
                Expanded(
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(25),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),

                // Send button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Handle send message
                      if (_messageController.text.isNotEmpty) {
                        print('Sending message: ${_messageController.text}');
                        _messageController.clear();
                      }
                    },
                    icon: Icon(Icons.send),
                    iconSize: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),

                // Microphone button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Handle microphone press
                      print('Recording audio...');
                    },
                    icon: Icon(Icons.mic),
                    iconSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

