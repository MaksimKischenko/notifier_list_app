// ignore_for_file: avoid_catches_without_on_clauses

import 'package:intl/intl.dart';

extension DateHelperString on String {

  DateTime? toDateFormatted() {
    final dateFormat = DateFormat('dd.MM.yyyy');
    try {
      return dateFormat.parse(this);
    } catch(err, _) {
      return null;
    }
  }

  DateTime? toDateFormattedOnlyTime() {
    final dateFormat = DateFormat('HH:mm');
    try {
      return dateFormat.parse(this);
    } catch(err, _) {
      return null;
    }
  }

   DateTime? toDateFormattedWithTime() {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    try {
      return dateFormat.parse(this);
    } catch(err, _) {
      return null;
    }
  }

}

extension DateHelperDateTime on DateTime {

  String toStringFormatted() => DateFormat('dd.MM.yyyy').format(this);

  String toStringFormattedGetOperationHistory() => DateFormat('dd.MM.yyyy HH:mm:ss').format(this);

  String toStringFormattedRunOperation() => DateFormat('dd.MM.yyyy HH:mm').format(this);

  String toStringFormattedHoursOnly() => DateFormat('HH:mm').format(this);

}

extension DateTimeExtension on DateTime? {
  String parseToString(String dateFormat) {
    if (this == null) return '';
    return DateFormat(dateFormat).format(this!);
  }
}

extension StringExtension on String {
  DateTime parseToDateTime(String dateFormat) {
    if (length > dateFormat.length) return DateTime.now();
    try {
      return DateFormat(dateFormat).parse(this);
    } on FormatException catch (_) {
      return DateTime.now();
    }
  }
}
