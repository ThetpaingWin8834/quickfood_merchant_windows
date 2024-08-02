import 'package:quick_merchant_windows/core/locale/my_locale.dart';

class CustomException implements Exception {
  final String message = MyLocale.unknownError;
  CustomException({String? message}) {
    message = message;
  }
}
