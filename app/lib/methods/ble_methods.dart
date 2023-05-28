// --------------------------------- BLE ---------------------------------
// all ble variables, methods and providers

import 'dart:async';
import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../data/preferences.dart';
import '../data/variables.dart';
import '../ui/widgets/toast.dart';
import 'alarm_methods.dart';
import 'globals_methods.dart';

BluetoothCharacteristic? cBattery;
BluetoothCharacteristic? cAlarm;
BluetoothCharacteristic? cCommand;
Stream<List<int>>? streamBattery;
Stream<List<int>>? streamAlarm;
Stream<List<int>>? streamCommand;

sendDataToDevice(String dataString) async {
  //Encoding the string
  List<int> data = utf8.encode(dataString);
  print(data);
  try { 
    await cCommand!.write(data);
    print("!!Success >> sent data : $dataString");
  } catch (e) {
    print("!! Failed  to send data : $dataString");
    print(e);
  }
}

disconnectFromDevice(BluetoothDevice? d) async {
  try {
    await d!.disconnect();
    await bleWatch.setDevice(null);
    await bleWatch.setConnectionState(false);
    print("..... disconnected device!");
  } catch (e) {
    printError("disconnecting", e);
  }
}

discoverServices(BluetoothDevice d) async {
  List<BluetoothService> services = await d.discoverServices();
  for (var service in services) {
    if (service.uuid.toString() == serviceUuid) {
      for (var characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == charaCteristicUuidBattery) {
          await characteristic.setNotifyValue(!characteristic.isNotifying);
          streamBattery = characteristic.value;
          cBattery = characteristic;
        }
        if (characteristic.uuid.toString() == charaCteristicUuidAlarm) {
          await characteristic.setNotifyValue(!characteristic.isNotifying);
          streamAlarm = characteristic.value;
          cAlarm = characteristic;
        }
        if (characteristic.uuid.toString() == charaCteristicUuidCommand) {
          await characteristic.setNotifyValue(!characteristic.isNotifying);
          streamCommand = characteristic.value;
          cCommand = characteristic;
        }
      }
    }
  }
}

Future<bool> connectDevice(BluetoothDevice device) async {
  try {
    await disconnectFromDevice(device);
    await device.connect();
    await discoverServices(device);
    print("..... connected device!");
    await bleWatch.setDevice(device);
    await bleWatch.setConnectionState(true);
    await prefs.setString("lastDeviceId", device.id.toString());
    await getAlarmList();
    await syncTime();

    device.state.listen((event) async {
      if (event != BluetoothDeviceState.connected) {
        toast(0, "Lost connection to device!");
        await bleWatch.setDevice(null);
        await bleWatch.setConnectionState(false);
        await alarmWatch.resetAlarmMap();
      }
    });
    return true;
  } catch (e) {
    printError("connect-device", e);
    return false;
  }
}

// the app will try to connect to the last connected device
Future<void> checkAlreadyConnectedDevices() async {
  print("....... trying to auto-connect");

  String? id = prefs.getString("lastDeviceId");
  FlutterBluePlus.instance.connectedDevices.then((devices) async {
    for (var device in devices) {
      try {
        if (device.id.toString() == id) {
          await discoverServices(device);
          await bleWatch.setDevice(device);
          await bleWatch.setConnectionState(true);
        }
      } catch (e) {
        printError("autoconnect", e);
      } finally {
        await getAlarmList();
        await syncTime();
      }
    }
  });
}

Future<void> syncTime() async {
  final now = DateTime.now();
  await sendDataToDevice("t${now.second}-${now.minute}-${now.hour}-${now.day}-${now.month}-${now.year}-");
}

Future<void> turnOffDevice() async {
  try {
    await sendDataToDevice('o');
    disconnectFromDevice(bleWatch.device);
  } catch (e) {
    printError("turn-off-device", e);
  }
}

String parseBLEData(List<int>? dataFromDevice) {
  if (dataFromDevice == [] && dataFromDevice == null) {
    return "404";
  } else {
    return utf8.decode(dataFromDevice!);
  }
}

Future<void> getBatteryPercentage() async {
  try {
    if (bleWatch.connected) {
      List<int>? value = await cBattery?.read();
      int percentage = int.parse(parseBLEData(value));
      if (percentage == 404) {
      } else if (percentage > 100) {
        percentage = 100;
      } else if (percentage < 0) {
        percentage = 0;
      } else {}

      bleWatch.updateBatteryPercentage(percentage);
    } else {
      // print("------ not connected!");
    }
  } catch (e) {
    printError("get-battery-percentage", e);
  }
}
