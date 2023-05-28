import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../../../methods/ble_methods.dart';
import '../../../methods/globals_methods.dart';
import '../../theme/theme.dart';
import '../../widgets/back_button.dart';
import '../../widgets/toast.dart';

class PairDeviceScreen extends StatefulWidget {
  const PairDeviceScreen({required this.firstTime, super.key});
  final bool firstTime;

  @override
  State<PairDeviceScreen> createState() => _PairDeviceScreenState();
}

class _PairDeviceScreenState extends State<PairDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: customBackButton(context, Colors.white),
        title: Column(
          children: [
            Text(
              'Select your Hapty',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.white54),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // stream a list of all BLE devices that are advertising
          Expanded(
            child: StreamBuilder<List<ScanResult>>(
              stream: FlutterBluePlus.instance.scanResults,
              initialData: [],
              builder: (c, snapshot) => Column(
                children: snapshot.data!.map((s) {
                  if (s.device.type == BluetoothDeviceType.le) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        onPressed: () async {
                          bool success = await connectDevice(s.device);
                          if (success) {
                            Navigator.pop(context);
                          } else {
                            toast(0, "Failed to connect Hapty!");
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Image.asset(
                                'assets/images/homie300.png',
                                height: w * 0.15,
                                width: w * 0.15,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                s.device.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBluePlus.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              onPressed: () => FlutterBluePlus.instance.stopScan(),
              backgroundColor: secondaryColor,
              child: Icon(Icons.stop),
            );
          } else {
            return FloatingActionButton(
                backgroundColor: secondaryColor,
                child: Icon(Icons.refresh),
                onPressed: () async {
                  if (await FlutterBluePlus.instance.isOn) {
                    FlutterBluePlus.instance.startScan(timeout: Duration(seconds: 4));
                  } else {
                    toast(0, "Bluetooth is off!");
                  }
                });
          }
        },
      ),
    );
  }
}
