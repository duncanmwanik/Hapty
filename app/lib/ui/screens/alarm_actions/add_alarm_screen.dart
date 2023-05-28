import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import '../../../data/variables.dart';
import '../../../methods/alarm_methods.dart';
import '../../../methods/datetime_methods.dart';
import '../../../methods/globals_methods.dart';
import '../../../models/date_models.dart';
import '../../../models/vibration_models.dart';
import '../../theme/theme.dart';
import '../../widgets/back_button.dart';

// ignore: must_be_immutable
class AddAlarmScreen extends StatefulWidget {
  const AddAlarmScreen({super.key});

  @override
  State<AddAlarmScreen> createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends State<AddAlarmScreen> {
  TextEditingController? descriptionText = TextEditingController(text: alarmWatch.alarm[6]);

  Widget vibrationPatternChoice(int choice) {
    return GestureDetector(
      onTap: (() {
        alarmWatch.updateAlarm(2, choice);
      }),
      child: Container(
        width: w * 0.08,
        height: w * 0.08,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(vibrationPatternList[choice].patternImage),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
          border: Border.all(
            width: choice == alarmWatch.alarm[2] ? 3 : 0.5,
            color: choice == alarmWatch.alarm[2] ? Colors.white : Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget dayWidget(DayObject day) {
    return GestureDetector(
      onTap: (() {
        alarmWatch.updateSelectedDaysList(day);
      }),
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: alarmWatch.selectedDaysList.contains(day.dayNumber) ? themeColor : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: SizedBox(
          width: 22,
          height: 22,
          child: Center(
              child: Text(
            day.dayShortName,
            style: TextStyle(fontWeight: FontWeight.w700, color: alarmWatch.selectedDaysList.contains(day.dayNumber) ? Colors.white : Colors.black),
          )),
        ),
      ),
    );
  }

  Widget selectDaysModeWidget(String selectedDaysMode) {
    return ElevatedButton(
      onPressed: () {
        alarmWatch.updateSelectedDaysMode(selectedDaysMode);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: alarmWatch.selectedDaysMode == selectedDaysMode ? Colors.red : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          selectedDaysMode,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: alarmWatch.selectedDaysMode == selectedDaysMode ? Colors.white : Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget repeatOption(int repeatOption) {
    return ElevatedButton(
      onPressed: () {
        alarmWatch.updateAlarm(1, repeatOption);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: alarmWatch.alarm[1] == repeatOption ? themeColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      child: Text(
        repeatOption == 1 ? "Yes" : "No",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: alarmWatch.alarm[1] == repeatOption ? Colors.white : Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget snoozeOption(int snoozeOption) {
    return ElevatedButton(
      onPressed: () {
        alarmWatch.updateAlarm(4, snoozeOption);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: alarmWatch.alarm[4] == snoozeOption ? themeColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      child: Text(
        snoozeMinList[snoozeOption],
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: alarmWatch.alarm[4] == snoozeOption ? Colors.white : Colors.black, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget textTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: customBackButton(context, Colors.white),
        title: Text(
          "Add a new alarm",
          style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              splashRadius: 30,
              onPressed: () => addNewAlarm(context),
              icon: Icon(
                Icons.check_rounded,
                color: themeColor,
                size: 30,
              ))
        ],
      ),
      body: Column(
        children: [
          // -------------------- Time
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
                  time: alarmWatch.alarm[5],
                  is24HourMode: false,
                  normalTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white30),
                  highlightedTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
                  spacing: 20,
                  itemHeight: 50,
                  isForce2Digits: true,
                  onTimeChange: (time) {
                    alarmWatch.alarm[5] = time;
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                // -------------------- Days
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < 7; i++) dayWidget(weekDaysList[i]),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          selectDaysModeWidget('Daily'),
                          selectDaysModeWidget('Weekdays'),
                          selectDaysModeWidget('Weekends'),
                          IconButton(
                              onPressed: () {
                                alarmWatch.updateSelectedDaysMode("-");
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                // -------------------- Alarm Description
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                //   padding: EdgeInsets.all(10),
                //   decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       textTitle("Description"),
                //       Container(
                //         padding: const EdgeInsets.symmetric(horizontal: 10),
                //         margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.all(Radius.circular(10)),
                //           border: Border.all(
                //             width: 0.5,
                //             color: primaryColor,
                //           ),
                //         ),
                //         child: TextField(
                //           controller: descriptionText,
                //           style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                //           decoration: InputDecoration(
                //             border: InputBorder.none,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // -------------------- Repeat Alarm
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Repeat alarm",
                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            repeatOption(1),
                            SizedBox(
                              width: 10,
                            ),
                            repeatOption(0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // -------------------- Snooze Alarm
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: textTitle(
                          "Snooze (minutes)",
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 3,
                          children: [
                            snoozeOption(0),
                            snoozeOption(1),
                            snoozeOption(2),
                            snoozeOption(3),
                            snoozeOption(4),
                            snoozeOption(5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // -------------------- Vibration Pattern --------------------
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  padding: EdgeInsets.only(top: 10, bottom: 15, left: 10, right: 10),
                  decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 1, child: textTitle("Vibration Pattern")),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [for (int i = 0; i < 4; i++) vibrationPatternChoice(i)],
                        ),
                      ),
                    ],
                  ),
                ),

                // -------------------- Vibration Strength --------------------
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
                  child: Column(
                    children: [
                      textTitle("Vibration Strength |  ${(alarmWatch.alarm[3] + 1) * 10}%"),
                      Slider(
                        label: "Select Strength",
                        thumbColor: themeColor,
                        activeColor: themeColor,
                        value: alarmWatch.alarm[3].toDouble(),
                        onChanged: (strength) {
                          alarmWatch.updateAlarm(3, strength.toInt());
                        },
                        onChangeEnd: (strength) {
                          print(strength.toInt());
                        },
                        min: 1,
                        max: 9,
                      ),
                    ],
                  ),
                ),
                // -------------------- Submit
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: h * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          addNewAlarm(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,
                            fixedSize: Size(w * 0.8, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                            )),
                        child: Text(
                          'Create',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
