import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger();

  static void i(String msg) => _logger.i(msg);
  static void d(String msg) => _logger.d(msg);
  
  // Fix the 'e' method call: passing the stackTrace as a named argument
  static void e(String msg, [StackTrace? stackTrace]) =>
      _logger.e(msg, stackTrace: stackTrace);

  static void w(String msg) => _logger.w(msg);
}
