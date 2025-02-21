import "package:intl/intl.dart" as intl;

class PriceModel {
  String? symbolName;
  String? price;
  String? date;
  double? changePercent;

  PriceModel({
    this.symbolName,
    this.price,
    this.date,
    this.changePercent,
  });

  PriceModel.fromJson(Map<String, dynamic> json) {
    final form = intl.NumberFormat("#,##0", "en_US");
    symbolName = json['symbol'];
    price = form.format(json['price']);
    date = json['date'];
    changePercent = json['change_percent'].toDouble();
  }

  Map<String, dynamic> toJson(PriceModel model) {
    return {
      'symbol': model.symbolName,
      'price': model.price,
      'date': model.date,
      'changePercent': model.changePercent
    };
  }
}
