import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:widget_home/core/common/user_notify.dart';
import 'package:widget_home/core/constants/api_keys.dart';
import 'package:widget_home/core/constants/crypto_currency_image_map.dart';
import 'package:widget_home/core/constants/urls.dart';
import 'package:widget_home/home/model/crypto_currency_model.dart';
import 'package:widget_home/home/model/currency_model.dart';
import 'package:widget_home/service/request_service.dart';

class HomeViewModel extends GetxController {
  final RequestService service;

  // currency list model
  final List<CurrencyModel> _priceModel = [];
  List<CurrencyModel> get getPriceModel => _priceModel;
  // crypto currency model
  final List<CryptoCurrencyModel> _cryptoCurrencyModel = [];
  List<CryptoCurrencyModel> get getCryptoCurrencyModel => _cryptoCurrencyModel;

  final String _appGroupId = "group.currencyPriceApp";
  final String _androidWidgetName = "DollarPrice";

  HomeViewModel(this.service);

  Future<void> getCurrencyPrice() async {
    final String url = Urls.baseUrl + await ApiKeys.getApiKey();
    final res = await service.getRequest(url);

    if (res != null) {
      Map<String, dynamic> decoded = jsonDecode(res.httpResponse!.body);
      _priceModel.clear();
      _cryptoCurrencyModel.clear();
      for (int index = 0; index < decoded['currency'].length; index++) {
        _priceModel.add(CurrencyModel.fromJson(decoded['currency'][index]));
      }
      for (int index = 0; index < decoded['cryptocurrency'].length; index++) {
        bool isExsits = CryptoCurrencyImageMap.imageCrypto(
                decoded['cryptocurrency'][index]['symbol']
                    .toString()
                    .toLowerCase())
            .isValid;
        String imagePath = CryptoCurrencyImageMap.imageCrypto(
                decoded['cryptocurrency'][index]['symbol']
                    .toString()
                    .toLowerCase())
            .value;
        if (isExsits) {
          _cryptoCurrencyModel.add(CryptoCurrencyModel.fromJson(
              decoded['cryptocurrency'][index], imagePath));
        }
      }
      log(_cryptoCurrencyModel.length.toString());
      _saveAndUpdateWidgetData();
      UserNotify.showSnackBar(
          'موفقیت آمیز', 'اطلاعات بروزرسانی شد ', Colors.green, Colors.white);
    } else {
      UserNotify.showSnackBar('خطا در ارتباط',
          'خطایی در هنگام دریافت اطلاعات رخ داد', Colors.red, Colors.white);
    }
  }

  Future<void> _saveAndUpdateWidgetData() async {
    List<String> listRawData = [];
    for (final model in _priceModel) {
      if (model.symbolName == "USD" || model.symbolName == "EUR") {
        listRawData.add(jsonEncode(model.toJson(model)));
      }
    }
    await HomeWidget.saveWidgetData("CurrencyData", listRawData.toString());
    await HomeWidget.updateWidget(androidName: _androidWidgetName);
    update();
  }

  @override
  void onInit() async {
    HomeWidget.setAppGroupId(_appGroupId);
    await getCurrencyPrice();
    super.onInit();
  }
}
