import 'package:rock_n_clouds/i18n/text_data.dart';

class EmptySearchException implements Exception {
  final String message = TextData.searchFieldError;
  EmptySearchException();
  @override
  String toString() {
    return message;
  }
}
