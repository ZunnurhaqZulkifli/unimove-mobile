import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/pages/dashboard.dart';
import 'package:unimove/pages/update_profile.dart';
import 'package:unimove/themes/theme.dart';

Future<dynamic> UpdateProfilePopup() {
  return Get.defaultDialog(
    titlePadding: EdgeInsets.only(top: 10),
    title: 'Uh Oh!',
    titleStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    content: Column(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image(
            image: AssetImage('assets/images/update_profile.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Note : We have noticed that you havent updated your profile yet, please update your profile to continue.',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        )
      ],
    ),
    barrierDismissible: false,
    actions: [
      OverflowBar(
        alignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.offAll(() => Dashboard());
            },
            child: Text('Later'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ElevatedButton(
              onPressed: () {
                Get.offAll(() => UpdateProfile());
              },
              child: Text(
                'Update',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.success6,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          )
        ],
      ),
    ],
  );
}

Future<dynamic> EnableBiometricsPopup() {
  return Get.defaultDialog(
    title: 'Tired of logging in ?',
    titleStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    middleText: 'Enable biometrics to login faster and more secure.',
    middleTextStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
    barrierDismissible: false,
    cancel: ElevatedButton(
      onPressed: () {
        Get.offAll(() => Dashboard());
      },
      child: Text('Later'),
    ),
    actions: [
      ElevatedButton(
        onPressed: () {
          Get.offAll(() => UpdateProfile());
        },
        child: Text('Update Now'),
      ),
    ],
  );
}
