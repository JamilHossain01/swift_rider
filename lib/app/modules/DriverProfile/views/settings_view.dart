import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common widget/home_screen_app_bar.dart';

import '../../setting/views/p_chnage_password_view.dart';
import '../../setting/widgets/setting_item.dart';
import 'edite_profile_view.dart';

class DriverAccountSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: HomeCustomAppBar(title: 'Settings'),
      body: Column(children: [
        SettingItem(
          title: 'Changes Password',
          trailing: Icon(Icons.chevron_right, color: Colors.black),
          onTap: () {
            Get.to(()=>ChangedNewPasswordView());

          },
        ),
      ],)

    );
  }
}