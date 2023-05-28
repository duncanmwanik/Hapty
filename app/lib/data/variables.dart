// -------------------- ALARMS
List<String> snoozeMinList = ["0", "5", "10", "20", "30", "60"];

//  where each elememt appears in the alarm String structure: 11091516:40  -> 1-1-0-9-1-5-16:40
int alarmActiveIndex = 0;
int alarmRepeatIndex = 1;
int vibrationPatternIndex = 2;
int vibrationStrengthIndex = 3;
int snoozeMinIndex = 4;
int alarmTimeIndex = 5;

// -------------------- BLE
String serviceUuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
String charaCteristicUuidBattery = "beb54800-36e1-4688-b7f5-ea07361b26a8";
String charaCteristicUuidAlarm = "beb54811-36e1-4688-b7f5-ea07361b26a8";
String charaCteristicUuidCommand = "beb54822-36e1-4688-b7f5-ea07361b26a8";

// -------------------- NAVIGATION
int lastPage = 1; // The default navbar index
