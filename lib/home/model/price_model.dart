import "package:intl/intl.dart" as intl;

class PriceModel {
  String? symbolName;
  String? buy;
  String? sell;
  String? date;

  PriceModel({
    this.symbolName,
    this.buy,
    this.sell,
    this.date,
  });

  PriceModel.fromJson(Map<String, dynamic> json) {
    final form = intl.NumberFormat("#,##0", "en_US");
    symbolName = json['symbol'];
    buy = form.format(json['buy']);
    sell = form.format(json['sell']);
    date =
        json['last_update'].toString().split(' ').first.replaceAll(r'-', ' ');
  }

  Map<String, dynamic> toJson(PriceModel model) {
    return {
      'symbol': model.symbolName,
      'buy': model.buy,
      'sell': model.sell,
      'date': model.date,
    };
  }
}
