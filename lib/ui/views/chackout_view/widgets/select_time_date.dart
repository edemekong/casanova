import 'package:flutter/material.dart';

selectDate(BuildContext context, {DateTime date}) async {
  final dateTime = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2023),
  );
  date = dateTime;
}

selectTime(BuildContext context, {TimeOfDay time}) async {
  final timeOfDay = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  time = timeOfDay;
}
