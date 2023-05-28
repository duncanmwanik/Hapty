import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import '../../../methods/globals_methods.dart';
import '../../theme/theme.dart';
import '../../widgets/alarm_widget.dart';

Future<void> showQuickAlarmEdit({required BuildContext context, required alarm}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        actions: [
          Hero(tag: alarm.alarmTime, child: alarmDetails(alarm: alarm, useSelectedTime: true)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Divider(
                      thickness: 1,
                      color: customColor,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Divider(
                      thickness: 1,
                      color: customColor,
                    )
                  ],
                ),
                TimePickerSpinner(
                  time: alarmWatch.selectedTime,
                  is24HourMode: false,
                  normalTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white30),
                  highlightedTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
                  spacing: 20,
                  itemHeight: 50,
                  isForce2Digits: true,
                  onTimeChange: (time) {
                    alarmWatch.updateSelectedTime(time);
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white10,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    )),
                onPressed: () {},
                child: Text(
                  "Additional settings",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white10,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    )),
                onPressed: () {},
                child: Text(
                  "Done",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
