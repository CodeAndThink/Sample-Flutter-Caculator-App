import 'package:caculator_app/configs/configs.dart';
import 'package:intl/intl.dart';

class ConverseNumber {
  static String converseToDefaultNumber(String input) {
    final numType = double.parse(input);
    return NumberFormat(Configs.numberFormat).format(numType);
  }
}
