
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RideActionSheet extends StatelessWidget {
  final String name;
  final String distance;
  final String price;
  final String buttonText;
  final VoidCallback onTap;

  const RideActionSheet({
    super.key,
    required this.name,
    required this.distance,
    required this.price,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage("assets/user.png"),
            ),
            title: Text(name),
            subtitle: Text(distance),
            trailing: Text(
              price,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: onTap,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
