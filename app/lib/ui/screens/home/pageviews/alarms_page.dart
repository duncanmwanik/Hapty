import 'package:flutter/material.dart';
import 'package:hapty/data/variables.dart';
import 'package:hapty/methods/datetime_methods.dart';
import 'package:hapty/models/alarm_model.dart';
import 'package:provider/provider.dart';

import '../../../../methods/alarm_methods.dart';
import '../../../../methods/globals_methods.dart';
import '../../../../state/alarms_state.dart';
import '../../../../state/global_state.dart';
import '../../../theme/theme.dart';
import '../../../widgets/alarm_widget.dart';
import '../../../widgets/date_widget.dart';

Widget alarmsPageView(BuildContext context) {
  Widget noAlarmBox() {
    return Padding(
        padding: EdgeInsets.only(top: h * 0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tap  \"",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white54),
            ),
            Icon(
              Icons.add_rounded,
              color: Colors.white70,
            ),
            Text(
              "\"  to add an alarm.",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white54),
            ),
          ],
        ));
  }

  return Consumer<AlarmModel>(builder: (context, a, child) {
    Map<int, List<String>> mapD = a.alarmMap;
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        Text(
          getWeekDay(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        // -------------------- Day Icons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            dateIcon(dayNumber: 0, alarmNumber: mapD[0]!.length),
            dateIcon(dayNumber: 1, alarmNumber: mapD[1]!.length),
            dateIcon(dayNumber: 2, alarmNumber: mapD[2]!.length),
            dateIcon(dayNumber: 3, alarmNumber: mapD[3]!.length),
            dateIcon(dayNumber: 4, alarmNumber: mapD[4]!.length),
            dateIcon(dayNumber: 5, alarmNumber: mapD[5]!.length),
            dateIcon(dayNumber: 6, alarmNumber: mapD[6]!.length),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Consumer<GlobalModel>(builder: (context, g, child) {
          if (a.alarmMap[g.selectedDate] != null) {
            if (a.alarmMap[g.selectedDate]!.isNotEmpty) {
              List<String> sortedList = sortAlarmsByTime(a.alarmMap[g.selectedDate]!);
              DateTime now = DateTime.now();

              return ListView.builder(
                  itemCount: sortedList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    String alarm = sortedList[index];
                    // 11091516:40  -> 1-1-0-9-1-5-16:40
                    //[ alarmActive-alarmRepeat-vibrationPattern-vibrationStrength-snoozeOn-snoozeMin-time ]

                    return alarmWidget(
                      context: context,
                      alarm: AlarmObject(
                          alarmActive: int.parse(alarm[alarmActiveIndex]),
                          alarmRepeat: int.parse(alarm[alarmRepeatIndex]),
                          vibrationPattern: int.parse(alarm[vibrationPatternIndex]),
                          vibrationStrength: int.parse(alarm[vibrationStrengthIndex]),
                          snoozeMin: int.parse(alarm[snoozeMinIndex]),
                          alarmTime: DateTime(now.year, now.month, now.day, int.parse(alarm.substring(alarmTimeIndex).split(":")[0]), int.parse(alarm.substring(alarmTimeIndex).split(":")[1]))),
                    );
                  });
            } else {
              return noAlarmBox();
            }
          } else {
            return noAlarmBox();
          }
        }),
      ],
    );
  });
}
