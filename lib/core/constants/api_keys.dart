import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKeys {
  static Future<String> getApiKey() async => dotenv.get('API_KEY');
}
