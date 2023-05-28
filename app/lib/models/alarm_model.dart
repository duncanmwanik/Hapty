class AlarmObject {
  int alarmActive;
  int alarmRepeat;
  int vibrationPattern;
  int vibrationStrength;
  int snoozeMin;
  DateTime alarmTime;

  AlarmObject({
    required this.alarmActive,
    required this.alarmRepeat,
    required this.vibrationPattern,
    required this.vibrationStrength,
    required this.snoozeMin,
    required this.alarmTime,
  });
}

class TestObject {
  int a;
  int b;

  TestObject({
    required this.a,
    required this.b,
  });
}
