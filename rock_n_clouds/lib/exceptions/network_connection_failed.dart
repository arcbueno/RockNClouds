import 'package:rock_n_clouds/i18n/text_data.dart';

class NetworkConnectionFailed implements Exception {
  final String message = TextData.networkConnectionError;
  NetworkConnectionFailed();
  @override
  String toString() {
    return message;
  }
}
