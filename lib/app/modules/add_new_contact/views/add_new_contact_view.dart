import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:swift_ride/app/modules/dashboard/views/dashboard_view.dart';

import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/home_screen_app_bar.dart';
import '../../../common widget/home_text_field.dart';
import '../../../common widget/success_full_page_view.dart';
import '../../../uitilies/app_colors.dart';
import '../../auth_view/view/otp_verify_filed_view.dart';
import '../controllers/add_new_contact_controller.dart';

class AddNewContactView extends GetView<AddNewContactController> {
  const AddNewContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeCustomAppBar(title: 'Add New Contact'),
      body: SingleChildScrollView(  // Wrap the whole body in SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HomeCustomTextField(
              labelText: 'First Name',
              hintText: 'First Name',
            ),
            HomeCustomTextField(
              labelText: 'Last Name',
              hintText: 'Last Name',
            ),
            HomeCustomTextField(
              labelText: 'Email',
              hintText: 'Email',
            ),
            SizedBox(height: 20.h),
            IntlPhoneField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Select Country and Enter Phone Number',
                labelText: 'Phone Number',
              ),
              initialCountryCode: 'BD', // Default to Bangladesh
              onChanged: (phone) {
                // Use controller to store phone number
              },
              showCountryFlag: true,
              showDropdownIcon: true,
              dropdownIconPosition: IconPosition.trailing,
              dropdownTextStyle: TextStyle(fontSize: 16.sp),
              validator: (value) {
                if (value == null || value.number.isEmpty) {
                  return 'Please enter a phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 250.h),

            // Align the button at the bottom of the screen
            Row(
              children: [
                SizedBox(
                  height: 55,
                  width: 100.w, // Fixed width for the Cancel button
                  child: CustomButtonWidget(
                    btnColor: Colors.white,
                    btnTextColor: Colors.black,
                    onTap: () {
                      // Logic to handle cancel
                    },
                    iconWant: false,
                    btnText: 'Cancel',
                  ),
                ),
                SizedBox(width: 40.w), // Add some space between the buttons
                Expanded(
                  child: SizedBox(
                    height: 55,
                    child: CustomButtonWidget(
                      btnColor: AppColors.mainColor,
                      onTap: () {
                        Get.to(()=>SuccesfullyPageForAll(title: 'Congratulations!', subTitle: 'Your reservation order has been successfully submitted. Once accepted, you will be able to complete your payment.', onTap: () {
                          Get.to(()=> UserDashboardView());
                        },));
                        // Logic to handle adding the new contact
                      },
                      iconWant: false,
                      btnText: 'Add New Contact',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),  // Add extra spacing at the bottom if needed
          ],
        ),
      ),
    );
  }
}
