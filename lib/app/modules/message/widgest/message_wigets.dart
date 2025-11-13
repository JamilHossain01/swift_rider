import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:swift_ride/app/uitilies/app_images.dart'; // Import the package

class MessageWidget extends StatelessWidget {
  final String message;
  final String audioDuration;
  final bool isSender;
  final bool useNetworkImage; // Condition to switch to network image

  // Constructor
  MessageWidget({
    required this.message,
    required this.audioDuration,
    required this.isSender,
    required this.useNetworkImage, // Add this flag
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
        isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender) ...[
            // Use AssetImage initially, then CachedNetworkImage later
            useNetworkImage
                ? CachedNetworkImage(
              imageUrl: 'https://via.placeholder.com/40x40/0077FF/FFFFFF?text=U', // Network URL
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 20,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
                : CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(AppImages.men1), // Local asset image
            ),
            SizedBox(width: 10),
          ],
          Column(
            crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 250),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSender ? Colors.blueAccent : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        color: isSender ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.mic,
                          size: 15,
                          color: isSender ? Colors.white70 : Colors.black54,
                        ),
                        SizedBox(width: 5),
                        Text(
                          audioDuration,
                          style: TextStyle(
                            color: isSender ? Colors.white70 : Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: 60,
                height: 2,
                color: Colors.grey.shade300,
              ),
            ],
          ),
          if (isSender) ...[
            SizedBox(width: 10),
            useNetworkImage
                ? CachedNetworkImage(
              imageUrl: 'https://via.placeholder.com/40x40/4CAF50/FFFFFF?text=S', // Network URL
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 20,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
                : CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(AppImages.men2), // Local asset image
            ),
          ],
        ],
      ),
    );
  }
}
