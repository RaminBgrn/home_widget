import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:widget_home/common/user_notify.dart';
import 'package:widget_home/core/constants/urls.dart';
import 'package:widget_home/home/model/price_model.dart';
import 'package:widget_home/service/request_service.dart';

class HomeViewModel extends GetxController {
  final RequestService service;

  final List<PriceModel> _priceModel = [];
  List<PriceModel> get getPriceModel => _priceModel;

  final String _appGroupId = "group.currencyPriceApp";
  final String _androidWidgetName = "DollarPrice";

  HomeViewModel(this.service);

  Future<void> getCurrencyPrice() async {
    final res = await service.getRequest(Urls.baseUrl);

    if (res != null) {
      Map<String, dynamic> decoded = jsonDecode(res.httpResponse!.body);
      _priceModel.clear();
      _priceModel.add(PriceModel.fromJson(decoded['USD']));
      _priceModel.add(PriceModel.fromJson(decoded['EUR']));
      _saveAndUpdateWidgetData();
      UserNotify.showSnackBar(
          'موفقیت آمیز', 'اطلاعات بروزرسانی شد ', Colors.green);
    } else {
      UserNotify.showSnackBar(
          'خطا در ارتباط', 'خطایی در هنگام دریافت اطلاعات رخ داد', Colors.red);
    }
  }

  Future<void> _saveAndUpdateWidgetData() async {
    List<String> listRawData = [];
    for (final model in _priceModel) {
      listRawData.add(jsonEncode(model.toJson(model)));
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
