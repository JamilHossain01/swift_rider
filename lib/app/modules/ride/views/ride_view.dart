import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ride_controller.dart';

class RideView extends GetView<RideController> {
  const RideView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RideView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RideView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
