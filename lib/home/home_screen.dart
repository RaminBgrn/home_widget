import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_home/home/model/currency_model.dart';
import 'package:widget_home/home/viewModel/home_view_model.dart';
import 'package:widget_home/home/widgets/crypto_currency_cart.dart';
import 'package:widget_home/home/widgets/main_cart_item.dart';

class HomeScreen extends GetView<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'قیمت دلار',
          style: GoogleFonts.vazirmatn(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getCurrencyPrice();
        },
        child: Icon(Icons.refresh),
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<HomeViewModel>(builder: (ctl) {
              return Row(
                children: [
                  Expanded(
                    child: MainCartItem(
                      model: () {
                        if (ctl.getPriceModel.isEmpty) {
                          return CurrencyModel();
                        } else {
                          return ctl.getPriceModel.singleWhere(
                              (currency) => currency.symbolName == "EUR");
                        }
                      }(),
                      image: 'assets/images/euro.png',
                      title: 'EUR',
                    ),
                  ),
                  Expanded(
                      child: MainCartItem(
                    model: () {
                      if (ctl.getPriceModel.isEmpty) {
                        return CurrencyModel();
                      } else {
                        return ctl.getPriceModel.singleWhere(
                            (currency) => currency.symbolName == "USD");
                      }
                    }(),
                    image: 'assets/images/usa.png',
                    title: 'USD',
                  )),
                ],
              );
            }),
            CryptoCurrencyCart(),
            Gap(8),
            ElevatedButton(
                onPressed: () {
                  if (Theme.of(context).brightness == Brightness.dark) {
                    Get.changeTheme(ThemeData.light());
                  } else {
                    Get.changeTheme(ThemeData.dark());
                  }
                },
                child: Text('Theme '))
          ],
        ),
      ),
    );
  }
}
