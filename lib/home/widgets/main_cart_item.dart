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
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                width: 46,
                height: 46,
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
                  model.price ?? 'null',
                  style: GoogleFonts.vazirmatn(
                      fontSize: 24,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  model.changePercent.toString(),
                  style: GoogleFonts.vazirmatn(
                      fontSize: 14,
                      color: () {
                        if (model.changePercent == null) {
                          return Colors.grey;
                        }
                        return model.changePercent! > 0
                            ? Colors.red.shade500
                            : Colors.green.shade500;
                      }(),
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
