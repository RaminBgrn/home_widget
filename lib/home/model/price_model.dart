import "package:intl/intl.dart" as intl;

class PriceModel {
  String? symbolName;
  String? price;
  double? changePercent;
  String? date;

  PriceModel({
    this.symbolName,
    this.price,
    this.changePercent,
    this.date,
  });

  PriceModel.fromJson(Map<String, dynamic> json) {
    final form = intl.NumberFormat("#,##0", "en_US");
    symbolName = json['symbol'];
    price = form.format(json['price']);
    changePercent = json['change_percent'] == 0
        ? double.tryParse(json['change_percent'])
        : json['change_percent'];
    date = json['date'];
  }

  Map<String, dynamic> toJson(PriceModel model) {
    return {
      'symbol': model.symbolName,
      'price': model.price,
      'changePercent': model.changePercent,
      'date': model.date,
    };
  }
}
