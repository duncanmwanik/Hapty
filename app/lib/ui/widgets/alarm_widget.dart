import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../methods/alarm_methods.dart';
import '../../methods/datetime_methods.dart';
import '../../methods/globals_methods.dart';
import '../../models/alarm_model.dart';
import '../screens/alarm_actions/quick_alarm_edit_dialog.dart';

Widget alarmWidget({required BuildContext context, required AlarmObject alarm}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: ElevatedButton(
      onPressed: () async {
        alarmWatch.updateSelectedTime(alarm.alarmTime);
        await showQuickAlarmEdit(context: context, alarm: alarm);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white10,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
      child: Hero(tag: alarm.alarmTime, child: alarmDetails(alarm: alarm, useSelectedTime: false)),
    ),
  );
}

Widget alarmDetails({required AlarmObject alarm, required bool useSelectedTime}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 11),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  useSelectedTime ? getFormattedTime(alarmWatch.selectedTime) : getFormattedTime(alarm.alarmTime),
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  useSelectedTime ? getTimePeriod(alarmWatch.selectedTime) : getTimePeriod(alarm.alarmTime),
                  style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            CupertinoSwitch(
                value: alarm.alarmActive == 1 ? true : false,
                onChanged: ((value) {
                  alarm.alarmActive = value ? 1 : 0;
                  changeAlarmActiveStatus(alarm: alarm);
                })),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            "Soon to ring",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14, color: Colors.white54, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ),
  );
}
