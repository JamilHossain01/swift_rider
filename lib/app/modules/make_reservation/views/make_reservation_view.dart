import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:swift_ride/app/common widget/home_screen_app_bar.dart';
import 'package:swift_ride/app/common%20widget/custom_button_widget.dart';
import 'package:swift_ride/app/common%20widget/home_text_field.dart';
import 'package:swift_ride/app/routes/app_pages.dart';
import 'package:swift_ride/app/uitilies/app_colors.dart';
import 'package:swift_ride/app/uitilies/app_images.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom text/row_common_text_widgets.dart';
import '../../../common widget/log_in_field.dart';
import '../controllers/make_reservation_controller.dart';
import '../wigets/contact_card_widgets.dart';
import '../wigets/date_time_widgets.dart';
import '../wigets/divider_text_widgets.dart';
import '../wigets/luggae_card.dart';
import '../wigets/order_details_widgets.dart';

class MakeReservationView extends GetView<MakeReservationController> {
  const MakeReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<DateTime?> pickUpDate = ValueNotifier<DateTime?>(null);
    ValueNotifier<TimeOfDay?> pickUpTime = ValueNotifier<TimeOfDay?>(null);
    ValueNotifier<DateTime?> dropOffDate = ValueNotifier<DateTime?>(null);
    ValueNotifier<TimeOfDay?> dropOffTime = ValueNotifier<TimeOfDay?>(null);
    final _isExpanded = ValueNotifier<bool>(false); // State for expansion
    RxString _selectedButton = "Hourly".obs;
    return Scaffold(
      appBar: HomeCustomAppBar(title: 'Make Reservation'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DividerTextWidgets(
                text: "Order Details",
              ),
              SizedBox(height: 10.h),
          
              // "Search for booking contact" expandable section
              SizedBox(
                width: double.infinity,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isExpanded,
                  builder: (context, isExpanded, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => _isExpanded.value = !_isExpanded.value,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      AppColors.reservationDropBorderTextColor),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  fontWeight: FontWeight.w400,
                                  text: "Search for booking contact",
                                  fontSize: 14.sp,

                                  color: Color(0xFF475467),
                                ),
                                Icon(
                                  isExpanded
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: Color(0xFF98A2B3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isExpanded)
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Column(
                              children: [
                                ContactCard(
                                  name: "Istak Ahmed",
                                  email: "istakm2739@gmail.com",
                                  phone: "+880 1234569819",
                                  initials: "IA",
                                ),
                                SizedBox(height: 10.h,),
                                CustomButtonWidget(btnColor: Colors.white,
                                    btnTextColor: AppColors.privacyTextColor,
                                    borderColor: AppColors.reservationDropBorderTextColor,
                                    btnText: 'Create new contact', onTap: (){
                                  Get.toNamed(Routes.ADD_NEW_CONTACT);

                                    }, iconWant: false)
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
          
              // "Order Type*" dropdown
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                ),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: AppColors.reservationDropBorderTextColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: CustomText(
                      text: "Order Type*",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF475467),
                    ),
                    icon: Icon(
                      Icons.expand_more,
                      color: Color(0xFF98A2B3),
                    ),
                    iconSize: 24,
                    elevation: 0,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16.sp),
                    onChanged: (String? newValue) {
                      // Handle selection logic here if needed
                    },
                    items: <String>[
                      'To the airport (Oneway)',
                      'From the airport (Oneway)',
                      'To/From the airport (Roundtrip)',
                      'From/To the airport (Roundtrip)'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: CustomText(
                          text: value,
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
          
              DividerTextWidgets(
                text: "Trip Type",
              ),
              Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: AppColors.reservationDropBorderTextColor),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => _buildButton(
                        'Hourly', _selectedButton, AppImages.clockWhite)),
                    Obx(() => _buildButton(
                        'One Way', _selectedButton, AppImages.boltLeft)),
                    Obx(() => _buildButton(
                        'Round Trip', _selectedButton, AppImages.boltLeft)),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
          
              DividerTextWidgets(
                text: "Trip Details",
              ),
              SizedBox(height: 10.h),
          
              ContactCard(
                name: "Istak Ahmed",
                email: "istakm2739@gmail.com",
                phone: "+880 1234569819",
                initials: "IA",
              ),
              SizedBox(height: 20.h),
          
              // DividerTextWidgets(
              //   text: "Date & Time",
              // ),
              // SizedBox(height: 10.h),


    Column(
      children: [
        DividerTextWidgets(
          text: "Date & Time",
        ),
        SizedBox(height: 10.h),
        DateandTimeWidgets(
          title: 'Pick-up Date',
          assetPath: AppImages.calensers1, // Assuming this path is defined in AppImages
          selectedDate: pickUpDate,
          selectedTime: pickUpTime, // Time is null initially
        ),
        SizedBox(height: 10.h),
        DateandTimeWidgets(
          title: 'Pick-up Time',
          assetPath: AppImages.time, // Assuming this path is defined in AppImages
          selectedDate: pickUpDate,
          selectedTime: pickUpTime,
        ),
        SizedBox(height: 10.h),
        DateandTimeWidgets(
          title: 'Drop-off Date',
          assetPath: AppImages.calensers1, // Assuming this path is defined in AppImages
          selectedDate: dropOffDate,
          selectedTime: dropOffTime, // Time is null initially
        ),
        SizedBox(height: 10.h),
        DateandTimeWidgets(
          title: 'Drop-off Time',
          assetPath: AppImages.time, // Assuming this path is defined in AppImages
          selectedDate: dropOffDate,
          selectedTime: dropOffTime,
        ),
      ],
    ),

              SizedBox(height: 10.h),


              DividerTextWidgets(
                text: "Pick-Up",
                showEditIcon: true,
                pickIpIon: true,
                initialFields: [
                  HomeCustomTextField(
                    labelText: 'Address',
                    hintText: 'Address',
                  ),
                ],

                fields: [
                  HomeCustomTextField(
                    labelText: 'Arrival Airport',
                    hintText: 'Arrival Airport',
                  ),
                  SizedBox(height: 10.h),
                  HomeCustomTextField(
                    labelText: 'Airline',
                    hintText: 'Airline',
                  ),
                  SizedBox(height: 10.h),
                  HomeCustomTextField(
                    labelText: 'Flight',
                    hintText: 'Flight',
                  ),

                ],
              ),


              SizedBox(height: 10.h),

              DividerTextWidgets(
                text: "Drop-Off",
                showEditIcon: true,
              ),
              SizedBox(height: 10.h),

              HomeCustomTextField(
                labelText: 'Address',
                hintText: 'Address',
              ),  SizedBox(height: 10.h),

              DividerTextWidgets(
                text: "Additional Info",
                showEditIcon: true,
              ),

              HomeCustomTextField(
                labelText: 'Passenger Count',
                hintText: 'Passenger Count',
              ),

              HomeCustomTextField(
                labelText: 'Trip Notes',
                hintText: 'Trip Notes',
              ),

              Divider(),
              LuggageWidget(),
              Divider(),
              SizedBox(height: 2.h,),
              CustomText(
                text: 'Vehicle',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.privacyTextColor,
              ),
              Divider(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                ),
                decoration: BoxDecoration(
                  border:
                  Border.all(color: AppColors.reservationDropBorderTextColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: CustomText(
                      text: "Select",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF475467),
                    ),
                    icon: Icon(
                      Icons.expand_more,
                      color: Color(0xFF98A2B3),
                    ),
                    iconSize: 24,
                    elevation: 0,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16.sp),
                    onChanged: (String? newValue) {
                      // Handle selection logic here if needed
                    },
                    items: <String>[
                      'Sub',
                      'Sedan',
                      'Tesla',
                      'Private'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: CustomText(
                          text: value,
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              SizedBox(height: 10.h,),

              CustomText(
                text: 'Pricing',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.privacyTextColor,
              ),
              Divider(),
              CustomText(
                text: 'Base Rate',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.privacyTextColor,
              ),

              HomeCustomTextField(
                labelText: 'Enter Amount',
                hintText: 'Enter Amount',
              ),
              // SizedBox(
              //   width: 150,
              //   child: CustomButtonWidget( btnColor: Colors.white,
              //       borderRadius: BorderRadius.circular(8),
              //       borderColor: AppColors.blueToggle,
              //       btnTextColor: AppColors.blueToggle,
              //       btnText:'Add Pricing', onTap: (){}, iconWant:false),
              // ),
              // SizedBox(height: 20.h),
              RowTexCommonWidgets(
                text1: 'Base Rate',
                text2: "\$110.00",
              ),
              Divider(),
              RowTexCommonWidgets(
                text1: 'Total',
                text2: "\$150.00",
              ),
              SizedBox(height: 10.h,),


              CustomText(
                text: 'Internal Comments',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.privacyTextColor,
              ),
              Divider(),
              HomeCustomTextField(
                labelText: 'Comment...',
                hintText: 'Comment',
              ),

              SizedBox(height: 20.h),
              CustomButtonWidget(btnText: 'Submit', onTap: (){}, iconWant: false)

              // Add more widgets as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      String buttonText, RxString selectedButton, String assestPath) {
    return GestureDetector(
      onTap: () {
        selectedButton.value = buttonText; // Update selected button
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: selectedButton.value == buttonText
              ? AppColors.blueToggle
              : AppColors.grayToggle,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: selectedButton.value == buttonText
                ? AppColors.blueToggle
                : AppColors.grayToggle,
            width: 2.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // Ensures row only takes up as much space as needed
          children: [
            // Display icon only if needed. Adjust image size as necessary.
            Image.asset(
              assestPath, // Make sure the image path is correct
              width: 14.w,
              height: 14.h,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 4.0), // Space between image and text
            CustomText(
              text: buttonText,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: selectedButton.value == buttonText
                  ? Colors.white
                  : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}


