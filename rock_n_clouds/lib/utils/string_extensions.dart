import 'package:string_normalizer/string_normalizer.dart';

extension StringExtensions on String {
  String normalized() {
    return StringNormalizer.normalize(this);
  }
}
