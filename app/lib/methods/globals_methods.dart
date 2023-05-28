// --------------------------------- GLOBALS ---------------------------------
// all other variables, methods and providers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/alarms_state.dart';
import '../state/ble_state.dart';
import '../state/global_state.dart';

// --------------------------------- Provider refs ---------------------------------
var globalWatch;
var bleWatch;
var alarmWatch;

void createProviderReferences({BuildContext? context}) {
  globalWatch = context?.watch<GlobalModel>();
  bleWatch = context?.watch<BleModel>();
  alarmWatch = context?.watch<AlarmModel>();
}

// --------------------------------- Screen Size ---------------------------------

// screen sizes
double h = 0;
double w = 0;

void getDeviceSize(BuildContext context) {
  // get device screen size and save them globally
  h = MediaQuery.of(context).size.height;
  w = MediaQuery.of(context).size.width;
}

// --------------------------------- Debug ---------------------------------
void printError(String where, var e) {
  print("!!! ERROR :: $where >> [[  $e  ]]");
}

// --------------------------------- Gestures ---------------------------------
void swipeToNextDay() async {
  int day = globalWatch.selectedDate;
  if (day == 6) {
    day = 0;
  } else {
    day++;
  }
  await globalWatch.updateSelectedDate(day);
  // print(day);
}

void swipeToPreviousDay() async {
  int day = globalWatch.selectedDate;
  if (day == 0) {
    day = 6;
  } else {
    day--;
  }
  await globalWatch.updateSelectedDate(day);

  // print(day);
}

void swipe(DragEndDetails details) {
  if (details.primaryVelocity == null) {
    return;
  }
  if (details.primaryVelocity! < 0) {
    swipeToNextDay();
  }
  if (details.primaryVelocity! > 0) {
    swipeToPreviousDay();
  }
}
