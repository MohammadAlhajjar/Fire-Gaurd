import 'package:intl/intl.dart';

class DateFormatHelper {
  static String getFormattedDate(String date) {
    return DateFormat('dd MMMM, yyyy').format(
      DateTime.parse(
        date,
      ),
    );
  }
}
