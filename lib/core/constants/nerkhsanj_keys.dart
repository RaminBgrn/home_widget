/// Key mapping of the Nerkhsanj live.json payload
/// (`rates` / `change` keys) to the symbols the app displays.
class NerkhsanjKeys {
  /// Fiat currencies: payload key -> currency symbol.
  static const Map<String, String> currencies = {
    'dollar': 'USD',
    'euro': 'EUR',
    'pound': 'GBP',
    'aed': 'AED',
    'lira': 'TRY',
    'yuan': 'CNY',
    'cad': 'CAD',
    'aud': 'AUD',
    'chf': 'CHF',
    'sar': 'SAR',
    'qar': 'QAR',
    'kwd': 'KWD',
    'omr': 'OMR',
    'afn': 'AFN',
    'rub': 'RUB',
    'inr': 'INR',
    'iqd': 'IQD',
  };

  /// Crypto currencies: payload key -> crypto symbol.
  static const Map<String, String> cryptos = {
    'bitcoin': 'BTC',
    'tether': 'USDT',
  };
}
