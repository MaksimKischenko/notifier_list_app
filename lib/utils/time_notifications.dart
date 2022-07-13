import 'package:flutter/material.dart';

int createUniqueId() {
  return DateTime.now().microsecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    required this.dayOfTheWeek,
    required this.timeOfDay,
  });
}

Future<NotificationWeekAndTime?> pickShedule(
  BuildContext context,
) async {
  TimeOfDay? timeOfDay = TimeOfDay.now();
  DateTime? _firstDate;
  DateTime? _lastDate;
  DateTime? _selectedDate;

  final date = await showDatePicker(
    context: context, 
    initialDate: _selectedDate ?? DateTime.now(),
    firstDate: _firstDate ?? DateTime.now(), 
    lastDate: _lastDate ?? DateTime(2100)
  ).whenComplete(() async {
    timeOfDay = await showTimePicker(
      context: context, 
      initialTime: timeOfDay ?? TimeOfDay.now()
    );
  });

 return NotificationWeekAndTime(
    dayOfTheWeek: date!.day,
    timeOfDay: timeOfDay!
 );
}
