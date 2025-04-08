class CryptoCurrencyImageMap {
  static final Map<String, String> _images = {
    'atom': 'assets/images/atom.png',
    'btc': 'assets/images/btc.png',
    'eth': 'assets/images/eth.png',
    'shib': 'assets/images/shib.png',
    'trx': 'assets/images/trx.png',
    'ustd': 'assets/images/ustd.png'
  };
  static ({String value, bool isValid}) imageCrypto(String key) {
    if (_images.containsKey(key)) {
      return (value: _images[key]!, isValid: true);
    }
    return (value: "", isValid: false);
  }
}
