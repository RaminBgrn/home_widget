import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_home/home/model/crypto_currency_model.dart';

class CryptoCurrencyItem extends StatelessWidget {
  final CryptoCurrencyModel model;
  const CryptoCurrencyItem({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(12),
        Image.asset(
          model.image!,
          width: 30,
          height: 30,
          fit: BoxFit.cover,
        ),
        Gap(8),
        Expanded(
          flex: 2,
          child: Text(
            model.title!,
            style: GoogleFonts.vazirmatn(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            model.price!,
            style: GoogleFonts.vazirmatn(
              fontSize: 16,
              color: Colors.red.shade400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            model.changePercent.toString(),
            style: GoogleFonts.vazirmatn(
              fontSize: 16,
              color: Colors.green.shade400,
            ),
          ),
        ),
      ],
    );
  }
}
