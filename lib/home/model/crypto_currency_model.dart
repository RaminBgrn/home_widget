class CryptoCurrencyModel {
  String? image;
  String? title;
  String? price;
  double? changePercent;

  CryptoCurrencyModel(
    this.image,
    this.title,
    this.price,
    this.changePercent,
  );

  CryptoCurrencyModel.fromJson(Map<String, dynamic> json, String imagePath) {
    image = imagePath;
    title = json['symbol'];
    price = json['price'];
    changePercent = json['change_percent'] is double
        ? json['change_percent']
        : double.tryParse(json['change_percent']);
  }
}
