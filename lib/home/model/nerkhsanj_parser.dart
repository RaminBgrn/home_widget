import 'package:widget_home/core/constants/crypto_currency_image_map.dart';
import 'package:widget_home/core/constants/nerkhsanj_keys.dart';
import 'package:widget_home/home/model/crypto_currency_model.dart';
import 'package:widget_home/home/model/currency_model.dart';

/// Parses a Nerkhsanj `live.json` payload into the app models.
///
/// Payload shape:
/// `{ "date": "1405/08/26", "time": "16:47",
///    "rates":  { "dollar": 267610, "euro": 294710, ... },
///    "change": { "dollar": -0.41,   "euro": -0.57,   ... } }`
/// Prices are in Toman, changes are percents.
class NerkhsanjParser {
  static List<CurrencyModel> parseCurrencies(Map<String, dynamic> decoded) {
    final rates = decoded['rates'];
    if (rates is! Map<String, dynamic>) return [];
    final changes = decoded['change'];
    final String date = [decoded['date'], decoded['time']]
        .where((e) => e != null)
        .join(' ');
    final List<CurrencyModel> result = [];
    NerkhsanjKeys.currencies.forEach((key, symbol) {
      final price = rates[key];
      if (price is num) {
        result.add(CurrencyModel.fromNerkhsanj(
          symbol: symbol,
          price: price,
          changePercent: changes is Map ? changes[key] as num? : null,
          date: date,
        ));
      }
    });
    return result;
  }

  static List<CryptoCurrencyModel> parseCryptos(Map<String, dynamic> decoded) {
    final rates = decoded['rates'];
    if (rates is! Map<String, dynamic>) return [];
    final changes = decoded['change'];
    final List<CryptoCurrencyModel> result = [];
    NerkhsanjKeys.cryptos.forEach((key, symbol) {
      final price = rates[key];
      if (price is num) {
        final image =
            CryptoCurrencyImageMap.imageCrypto(symbol.toLowerCase());
        if (image.isValid) {
          result.add(CryptoCurrencyModel.fromNerkhsanj(
            symbol: symbol,
            price: price,
            changePercent: changes is Map ? changes[key] as num? : null,
            imagePath: image.value,
          ));
        }
      }
    });
    return result;
  }
}
