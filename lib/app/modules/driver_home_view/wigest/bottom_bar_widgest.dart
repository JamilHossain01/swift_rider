import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final Function centerOnUser;
  final Function refreshTaxis;

  const BottomNavigationBarWidget({
    Key? key,
    required this.centerOnUser,
    required this.refreshTaxis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.my_location, color: Colors.blue.shade700),
                onPressed: () => centerOnUser(),
              ),
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.grey.shade700),
                onPressed: () => refreshTaxis(),
              ),
              IconButton(
                icon: Icon(Icons.chat_bubble, color: Colors.blue.shade700),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.grey.shade700),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
