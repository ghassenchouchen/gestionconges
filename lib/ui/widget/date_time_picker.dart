import 'package:flutter/material.dart';
import 'package:pfeconges/data/core/extensions/date_time.dart';

Future<DateTime?> pickDate(
    {required BuildContext context, required DateTime initialDate}) async {
  DateTime now = DateTime.now();

  DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: initialDate.isAfter(now)
          ? initialDate
          : now, 
      firstDate: now,
      lastDate: DateTime(DateTime.now().futureDateSelectionYear),
   
       builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
          primary: Color.fromARGB(255, 55, 96, 221),
          secondary:   Color.fromARGB(255, 55, 96, 221),

        ),
          buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary
          ),
        ),
        child: child!,
      );
    },
      );
  return pickDate;
}

Future<TimeOfDay?> pickTime(
    {required BuildContext context, required TimeOfDay initialTime}) async {
  TimeOfDay? time =
      await showTimePicker(context: context, initialTime: initialTime);
  return time;
}
