import 'package:flutter/foundation.dart';

class CustomException implements Exception {
  final cause;
  CustomException({@required this.cause});
}
