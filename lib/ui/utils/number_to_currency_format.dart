import 'package:intl/intl.dart';

final converter = new NumberFormat("#,##0.00", "en_US");

convertNumberToCurrency(int value) {
  return converter.format(value);
}
