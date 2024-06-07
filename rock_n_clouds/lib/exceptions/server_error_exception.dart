import 'package:rock_n_clouds/i18n/text_data.dart';

class ServerErrorException implements Exception {
  final String message = TextData.serverError;
  ServerErrorException();
  @override
  String toString() {
    return message;
  }
}
