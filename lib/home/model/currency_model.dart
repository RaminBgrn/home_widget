import "package:intl/intl.dart" as intl;

class CurrencyModel {
  String? symbolName;
  String? price;
  double? changePercent;
  String? date;

  CurrencyModel({
    this.symbolName,
    this.price,
    this.changePercent,
    this.date,
  });

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    final form = intl.NumberFormat("#,##0", "en_US");
    symbolName = json['symbol'];
    price = form.format(json['price']);
    changePercent = json['change_percent'] is double
        ? json['change_percent']
        : double.tryParse(json['change_percent'].toString());
    date = json['date'];
  }

  factory CurrencyModel.fromNerkhsanj({
    required String symbol,
    required num price,
    required num? changePercent,
    String? date,
  }) {
    final form = intl.NumberFormat("#,##0", "en_US");
    return CurrencyModel(
      symbolName: symbol,
      price: form.format(price),
      changePercent: changePercent?.toDouble(),
      date: date,
    );
  }

  Map<String, dynamic> toJson(CurrencyModel model) {
    return {
      'symbol': model.symbolName,
      'price': model.price,
      'changePercent': model.changePercent,
      'date': model.date,
    };
  }
}
