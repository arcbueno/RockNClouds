import 'package:rock_n_clouds/i18n/text_data.dart';

class CityNotFoundException implements Exception {
  final String message = TextData.cityNotFound;
  CityNotFoundException();
  @override
  String toString() {
    return message;
  }
}
