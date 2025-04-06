import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CryptoCurrencyItem extends StatelessWidget {
  const CryptoCurrencyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/usa.png',
          width: 20,
          height: 20,
        ),
        Text(
          'CHF',
          style: GoogleFonts.vazirmatn(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '103,800',
          style: GoogleFonts.vazirmatn(
            fontSize: 16,
            color: Colors.red.shade400,
          ),
        ),
        Text(
          '82,240',
          style: GoogleFonts.vazirmatn(
            fontSize: 16,
            color: Colors.green.shade400,
          ),
        ),
      ],
    );
  }
}
