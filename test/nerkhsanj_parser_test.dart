import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:widget_home/home/model/nerkhsanj_parser.dart';

/// Real sample captured from https://nerkh.jahankhahan.shop/data/live.json
/// on 2026-11-17 (trimmed to the keys the app consumes + a few extra).
const _sample = '''
{
  "date": "1405/08/26",
  "time": "16:47",
  "rates": {
    "dollar": 267610,
    "euro": 294710,
    "yuan": 40150,
    "gold": 24630900,
    "coin": 251710000,
    "aed": 72917,
    "pound": 353130,
    "tether": 269354,
    "bitcoin": 17536444900,
    "iqd": 171.8
  },
  "change": {
    "dollar": -0.41,
    "euro": -0.57,
    "tether": -0.02,
    "bitcoin": -0.17
  },
  "ounce": 3857.99
}
''';

void main() {
  final decoded = jsonDecode(_sample) as Map<String, dynamic>;

  group('NerkhsanjParser.parseCurrencies', () {
    final currencies = NerkhsanjParser.parseCurrencies(decoded);

    test('USD and EUR are present for the home cards and the widget', () {
      final usd = currencies.singleWhere((c) => c.symbolName == 'USD');
      final eur = currencies.singleWhere((c) => c.symbolName == 'EUR');
      expect(usd.price, '267,610');
      expect(eur.price, '294,710');
    });

    test('change percent and date are carried over', () {
      final usd = currencies.singleWhere((c) => c.symbolName == 'USD');
      expect(usd.changePercent, -0.41);
      expect(usd.date, '1405/08/26 16:47');
    });

    test('gold/coin keys are not mapped as fiat currencies', () {
      expect(currencies.any((c) => c.symbolName == 'GOLD'), isFalse);
      // dollar, euro, yuan, aed, pound, iqd from the sample
      expect(currencies.length, 6);
    });
  });

  group('NerkhsanjParser.parseCryptos', () {
    final cryptos = NerkhsanjParser.parseCryptos(decoded);

    test('BTC is parsed with its image and formatted price', () {
      final btc = cryptos.singleWhere((c) => c.title == 'BTC');
      expect(btc.image, 'assets/images/btc.png');
      expect(btc.price, '17,536,444,900');
      expect(btc.changePercent, -0.17);
    });

    test('USDT is not filtered out by the old ustd image-map typo', () {
      final usdt = cryptos.singleWhere((c) => c.title == 'USDT');
      expect(usdt.image, 'assets/images/ustd.png');
      expect(usdt.price, '269,354');
    });
  });

  test('missing rates map yields empty lists instead of throwing', () {
    expect(NerkhsanjParser.parseCurrencies({}), isEmpty);
    expect(NerkhsanjParser.parseCryptos({}), isEmpty);
  });
}
