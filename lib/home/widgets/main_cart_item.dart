import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_home/home/model/price_model.dart';

class MainCartItem extends StatelessWidget {
  final PriceModel model;
  final String image;
  final String title;
  const MainCartItem(
      {required this.image,
      required this.title,
      required this.model,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(width: 1, color: Colors.blue.shade100),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 4),
              color: Colors.grey.shade200,
              blurRadius: 12,
            )
          ]),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                image,
                width: 50,
                height: 50,
              ),
              Text(
                title,
                style: GoogleFonts.vazirmatn(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              )
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  model.date ?? 'null',
                  style: GoogleFonts.vazirmatn(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  model.sell ?? 'null',
                  style: GoogleFonts.vazirmatn(
                      fontSize: 24,
                      color: Colors.red.shade500,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  model.buy ?? 'null',
                  style: GoogleFonts.vazirmatn(
                      fontSize: 18,
                      color: Colors.green.shade500,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
