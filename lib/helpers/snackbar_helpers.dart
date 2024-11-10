import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimove/themes/theme.dart';

SnackbarController topSnackBarSuccess({
  required String title,
  required String message,
}) {
  return Get.snackbar(
    '',
    '',
    titleText: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        fontSize: 15,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: ThemeColors.success4,
    dismissDirection: DismissDirection.up,
    barBlur: 0.4,
    colorText: Colors.white,
    borderRadius: 8,
  );
}

SnackbarController bottomSnackBarSuccess({
  required String title,
  required String message,
}) {
  return Get.snackbar(
    '',
    '',
    titleText: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        fontSize: 15,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: ThemeColors.primary4,
    dismissDirection: DismissDirection.up,
    barBlur: 0.4,
    colorText: Colors.white,
    borderRadius: 8,
  );
}

SnackbarController topSnackBarError({
  required title,
  required message,
}) {
  return Get.snackbar(
    '',
    '',
    titleText: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        fontSize: 15,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: ThemeColors.danger5,
    dismissDirection: DismissDirection.up,
    barBlur: 0.4,
    colorText: Colors.white,
    borderRadius: 8,
  );
}

SnackbarController bottomSnackBarError({
  required title,
  required message,
}) {
  return Get.snackbar(
    '',
    '',
    titleText: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        fontSize: 15,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: ThemeColors.danger5,
    dismissDirection: DismissDirection.up,
    barBlur: 0.4,
    colorText: Colors.white,
    borderRadius: 8,
  );
}

SnackbarController topSnackBarAction({
  required title,
  required message,
  duration = const Duration(seconds: 3),
}) {
  return Get.snackbar(
    duration: duration,
    '',
    '',
    titleText: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        fontSize: 15,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 3,
        offset: const Offset(0, 3),
      ),
    ],
    snackPosition: SnackPosition.TOP,
    backgroundColor: const Color.fromARGB(255, 255, 123, 0),
    dismissDirection: DismissDirection.up,
    barBlur: 0.4,
    colorText: Colors.white,
    borderRadius: 8,
  );
}

SnackbarController bottomSnackBarAction({
  required title,
  required message,
}) {
  return Get.snackbar(
    '',
    '',
    titleText: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        fontSize: 15,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: ThemeColors.warning5,
    dismissDirection: DismissDirection.up,
    barBlur: 0.4,
    colorText: Colors.white,
    borderRadius: 8,
  );
}

SnackbarController topSnackBarInfo({
  required title,
  required message,
}) {
  return Get.snackbar(
    '',
    '',
    titleText: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        fontSize: 15,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: ThemeColors.info7,
    dismissDirection: DismissDirection.up,
    barBlur: 0.4,
    colorText: Colors.white,
    borderRadius: 8,
  );
}

SnackbarController bottomSnackBarInfo({
  required title,
  required message,
}) {
  return Get.snackbar(
    '',
    '',
    titleText: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
        fontSize: 15,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: ThemeColors.info7,
    dismissDirection: DismissDirection.up,
    barBlur: 0.4,
    colorText: Colors.white,
    borderRadius: 8,
  );
}
