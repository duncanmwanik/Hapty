// --------------------------------- ALARMS ---------------------------------
// any variable to do with alarm manipulation

import 'dart:convert';
import 'package:flutter/material.dart';
import '../data/preferences.dart';
import '../models/date_models.dart';

class AlarmModel with ChangeNotifier {
  // ---------- alarm Map
  Map<int, List<String>> alarmMap = {
    0: [],
    1: [],
    2: [],
    3: [],
    4: [],
    5: [],
    6: ["111908:56", "0133416:40"]
  };

  void updateAlarmMap(Map<int, List<String>> val) {
    alarmMap = val;
    notifyListeners();
  }

  void resetAlarmMap() {
    // alarmMap = {0: [], 1: [], 2: [], 3: [], 4: [], 5: [], 6: []};
    notifyListeners();
  }

  // ---------- active/selcted alarm details
  List<dynamic> alarm = [1, 1, 0, 3, 0, DateTime.now(), "", 0, DateTime.now()];

  void updateAlarm(int index, dynamic newData) {
    alarm[index] = newData;
    notifyListeners();
  }

  void resetAlarm() {
    alarm = [1, 1, 0, 3, 0, DateTime.now(), "", 0, DateTime.now()];
    notifyListeners();
  }

  // ----------
  String selectedDaysMode = "";

  void updateSelectedDaysMode(String mode) {
    selectedDaysMode = mode;
    if (mode == 'Daily') {
      selectedDaysList.clear();
      selectedDaysList.addAll([0, 1, 2, 3, 4, 5, 6]);
      selectedDaysList.sort();
    } else if (mode == 'Weekdays') {
      selectedDaysList.clear();
      selectedDaysList.addAll([1, 2, 3, 4, 5]);
      selectedDaysList.sort();
    } else if (mode == 'Weekends') {
      selectedDaysList.clear();
      selectedDaysList.addAll([0, 6]);
      selectedDaysList.sort();
    } else {
      selectedDaysList.clear();
    }
    notifyListeners();
  }

  // ----------
  List<int> selectedDaysList = [];

  void updateSelectedDaysList(DayObject day) {
    selectedDaysList.contains(day.dayNumber) ? selectedDaysList.remove(day.dayNumber) : selectedDaysList.add(day.dayNumber);
    selectedDaysList.sort();
    selectedDaysMode = "";
    notifyListeners();
  }

  // ----------
  DateTime selectedTime = DateTime.now();

  void updateSelectedTime(DateTime time) {
    selectedTime = time;
    notifyListeners();
  }

  // ---------- alarm names
  Map<String, String> alarmNamesMap = {};

  void getAlarmNames() {
    alarmNamesMap = jsonDecode(prefs.getString("alarmNames") ?? "{}");
    notifyListeners();
  }

  void updateAlarmName(String alarm, String name) {
    alarmNamesMap[alarm] = name;
    notifyListeners();
    saveAlarmNames();
  }

  void deleteAlarmName(String alarm) {
    alarmNamesMap.remove(alarm);
    notifyListeners();
    saveAlarmNames();
  }
}
