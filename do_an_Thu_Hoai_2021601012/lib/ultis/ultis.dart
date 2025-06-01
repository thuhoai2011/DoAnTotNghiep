import 'package:intl/intl.dart';

extension FormatCurrencyEx on dynamic {
  String toVND({String? unit = 'đ'}) {
    int number = int.parse(this.toString());
    var vietNamFormatCurrency =
        NumberFormat.currency(locale: "vi-VN", symbol: unit);
    return vietNamFormatCurrency.format(number);
  }
}