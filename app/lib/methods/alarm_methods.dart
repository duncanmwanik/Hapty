// --------------------------------- Alarm Methods ---------------------------------

// sorts alarms according to time set
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hapty/ui/widgets/confirm_delete_dialog.dart';

import '../ui/widgets/toast.dart';
import 'ble_methods.dart';
import 'globals_methods.dart';

List<String> sortAlarmsByTime(List<String> ls) {
  Map<int, String> mp = {};
  for (String e in ls) {
    mp[int.parse(e.substring(5).split(":").join(""))] = e;
  }
  mp = SplayTreeMap<int, String>.from(mp, (k1, k2) => k1.compareTo(k2));

  return mp.values.toList();
}

void addNewAlarm(BuildContext context) async {
  if (alarmWatch.selectedDaysList.isNotEmpty) {
    if (bleWatch.btState) {
      if (bleWatch.connected) {
        await globalWatch.showLoadingScreen(true);
        try {
          String days = alarmWatch.selectedDaysList.join("");
          String time = "${alarmWatch.alarm[5].hour}:${alarmWatch.alarm[5].minute}";
          String data = "a${alarmWatch.alarm[0]}${alarmWatch.alarm[1]}${alarmWatch.alarm[2]}${alarmWatch.alarm[3]}${alarmWatch.alarm[4]}$time/$days";
          print(data);
          await sendDataToDevice(data);
          // await globalWatch.updateAlarmName(alarm: time, name: alarmName);
          // await Future.delayed(Duration(milliseconds: 500), () {});
          await getAlarmList();
          await globalWatch.showLoadingScreen(false);
          Navigator.pop(context);
        } catch (e) {
          await globalWatch.showLoadingScreen(false);
          toast(0, "Failed to add alarm!!");
          printError("add-alarm", e);
        }
      } else {
        toast(0, "No device connected!");
      }
    } else {
      toast(0, "Bluetooth is off");
    }
  } else {
    toast(0, "Select at least one day!");
  }
}

Future<bool> editAlarm(BuildContext context) async {
  try {
    String time = '${alarmWatch.alarm[5].hour}:${alarmWatch.alarm[5].minute}';
    String prev = '${alarmWatch.alarm[8].hour}:${alarmWatch.alarm[8].minute}';
    String data = "e${alarmWatch.alarm[7]}/$prev/${alarmWatch.alarm[0]}${alarmWatch.alarm}[1]${alarmWatch.alarm[2]}${alarmWatch.alarm[3]}${alarmWatch.alarm[4]}$time";
    await sendDataToDevice(data);
    return true;
  } catch (e) {
    printError("edit-alarm", e);
    return false;
  }
}

Future<void> deleteAlarm({required BuildContext context, required int day, required DateTime alarmTime}) async {
  try {
    bool? toDelete = await showConfirmDeletionDialog(context);
    if (toDelete == true) {
      String time = '${alarmTime.hour}:${alarmTime.minute}';
      await sendDataToDevice('d$day/$time');
      toast(1, "Deleted!");
      // await globalWatch.deleteAlarm(alarm: time);
    }
  } catch (e) {
    printError("delete-alarm", e);
  }
}

// getting all alarms from the device
Future<void> getAlarmList() async {
  try {
    if (bleWatch.connected) {
      // tell the device to prepare the alarm list
      await sendDataToDevice("g");
      // read the alarm list data
      List<int>? data = await cAlarm?.read();

      List<String> days = parseBLEData(data).split("#");
      Map<int, List<String>> all = {};

      if (days.length < 7) {
        for (int day = 0; day < 7; day++) {
          all[day] = [];
        }
      } else {
        for (int day = 0; day < days.length; day++) {
          // if the alarm list is invalid
          if (days[day].length < 8) {
            all[day] = [];
          } else {
            // removes the extra "|" at the end of each day's alarm list
            String dayList = days[day].substring(0, days[day].length - 1);
            all[day] = dayList.split("|");
          }
        }
      }

      alarmWatch.updateAlarmMap(all);
      // print("_____________________________");
      // print("::::: ALARM-MAP : $all");
      // print("_____________________________");
    } else {
      toast(0, "No device connected!");
    }
  } catch (e) {
    toast(0, "Failed to get your alarms! Try to reconnect the device.");
    printError("get-alarms", e);
  }
}

String getNewAlarmData({required alarm}) {
  String alarmData = "";
  return alarmData;
}

void changeAlarmActiveStatus({required alarm}) {
  getNewAlarmData(alarm: alarm);
}
