import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserNotify {
  static void showSnackBar(String title, String message, Color primaryColor) {
    Get.snackbar('', '',
        titleText: Text(
          title,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.vazirmatn(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        messageText: Text(
          message,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.vazirmatn(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.black54,
          ),
        ),
        backgroundColor: primaryColor.withValues(
          alpha: 0.2,
        ),
        borderColor: primaryColor,
        borderWidth: 1,
        snackPosition: SnackPosition.BOTTOM);
  }
}
