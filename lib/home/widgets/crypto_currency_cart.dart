import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_home/home/viewModel/home_view_model.dart';
import 'package:widget_home/home/widgets/crypto_currency_item.dart';

class CryptoCurrencyCart extends StatelessWidget {
  const CryptoCurrencyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 210,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.blue.shade100),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 4),
              color: Colors.grey.shade200,
              blurRadius: 12,
            )
          ]),
      child: GetBuilder<HomeViewModel>(builder: (ctl) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(ctl.getCryptoCurrencyModel.length, (index) {
            return CryptoCurrencyItem(model: ctl.getCryptoCurrencyModel[index]);
          }),
        );
      }),
    );
  }
}
