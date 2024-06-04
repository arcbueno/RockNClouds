import 'package:rock_n_clouds/i18n/text_data.dart';

class UnexpectedError implements Exception {
  final String message = TextData.unexpectedError;
  UnexpectedError();
  @override
  String toString() {
    return message;
  }
}
