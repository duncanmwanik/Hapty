import 'package:flutter/material.dart';
import 'package:hapty/ui/theme/theme.dart';

import '../../methods/datetime_methods.dart';
import '../../methods/globals_methods.dart';

Widget dateIcon({required int dayNumber, required int alarmNumber}) {
  return ElevatedButton(
    onPressed: () {
      globalWatch.updateSelectedDate(dayNumber);
    },
    style: ElevatedButton.styleFrom(backgroundColor: globalWatch.selectedDate == dayNumber ? themeColor : Colors.white, minimumSize: Size(w * 0.1, w * 0.1), shape: CircleBorder()),
    child: Text(
      weekDaysList[dayNumber].dayShortName,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: globalWatch.selectedDate == dayNumber ? Colors.white : Colors.black),
    ),
  );
}
