import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

import '../../../common widget/home_screen_app_bar.dart';
import '../controllers/message_controller.dart';
import '../widgest/chat_list.dart';

class MessageView extends GetView<MessageController> {
  MessageView({super.key});

  // Sample demo lists (replace with API/Controller data later)
  final List<String> names = [
    "John Doe",
    "Emma Watson",
    "David Miller",
    "Sophia Lee",
    "Liam Carter",
    "Olivia Brown",
    "James Wilson",
    "Ava Taylor",
    "Michael Johnson",
  ];

  final List<String> subtitles = [
    "Tesla Model X",
    "Toyota Prius",
    "Honda Civic",
    "BMW 3 Series",
    "Audi A6",
    "Mercedes C-Class",
    "Hyundai Sonata",
    "Kia Sportage",
    "Ford Mustang",
  ];

  final List<String> images = [
    AppImages.profile1,
    AppImages.profile1,
    AppImages.profile1,
    AppImages.profile1,
    AppImages.profile1,
    AppImages.profile1,
    AppImages.profile1,
    AppImages.profile1,
    AppImages.profile1,
    AppImages.profile1,

  ];

  final List<double> ratings = [
    4.5,
    4.8,
    4.2,
    4.6,
    4.9,
    4.3,
    4.7,
    4.1,
    5.0,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeCustomAppBar(title: 'Message',showBackButton: false,),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return ChatListCard(
            profileImage: images[index],
            name: names[index],
            subtitle: subtitles[index],
            rating: ratings[index],
          );
        },
      ),
    );
  }
}
