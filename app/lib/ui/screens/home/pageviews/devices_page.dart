import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import '../../../../methods/ble_methods.dart';
import '../../../../methods/globals_methods.dart';
import '../../../../state/ble_state.dart';
import '../../../theme/theme.dart';
import '../../../widgets/battery_icon.dart';
import '../../../widgets/change_name_dialog.dart';
import '../../../widgets/toast.dart';
import '../../ble_pairing/pairing_screen.dart';

Widget devicesPageView(BuildContext context) {
  // initState() {
  //   super.initState();

  //   controller.addListener(() {
  //     if (controller.value) {
  //     } else {
  //       turnOffDevice();
  //     }
  //   });

  //   timer = Timer.periodic(Duration(seconds: 10), (timer) async {
  //     await getBatteryPercentage();
  //   });
  // }
  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }

  return Consumer<BleModel>(builder: (context, ble, child) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        Text(
          "My Devices",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 8,
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Connect your Hapty to add, edit and get alarms. You can also check your Hapty's battery health.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.white54, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
          ),
        ),
        ble.connected
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.only(bottom: 5),
                width: w * 0.8,
                decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              ble.device!.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () async {
                                TextEditingController? textController = TextEditingController(text: ble.device!.name);

                                bool success = await changeNameDialog(
                                    context: context,
                                    description: "Edit your Hapty's name",
                                    textController: textController,
                                    maxLength: 19,
                                    onTap: () {
                                      if (textController.text.isNotEmpty && textController.text.length < 20) {
                                        sendDataToDevice("n${textController.text}");
                                        Navigator.pop(context, true);
                                      } else if (textController.text.length >= 20) {
                                        toast(0, "Aah! too long...");
                                      } else {
                                        toast(0, "Noo! too short...");
                                      }
                                    });

                                if (success) {
                                  toast(1, "Reconnect your Hapty to see the change.");
                                }
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 19,
                              ))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            batteryIcon(ble.batteryPercentage),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              ble.batteryPercentage == 404 ? "--" : "${ble.batteryPercentage}%",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        AdvancedSwitch(
                          activeChild: Text('ON'),
                          inactiveChild: Text('OFF'),
                          borderRadius: BorderRadius.circular(5),
                          width: 76,
                          // controller: controller,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        disconnectFromDevice(ble.device);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white24,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      child: Text(
                        "disconnect",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: themeColor, fixedSize: Size(w * 0.35, h * 0.35), shape: CircleBorder()),
                    onPressed: () async {
                      if (ble.btState) {
                        FlutterBluePlus.instance.startScan(timeout: Duration(seconds: 4));
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PairDeviceScreen(
                                    firstTime: false,
                                  )),
                        );
                      } else {
                        toast(0, "Bluetooth is off!");
                      }
                    },
                    child: Icon(
                      Icons.add_rounded,
                      size: h * 0.10,
                      color: Colors.black,
                    ),
                  ),
                  Row(
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
                        "\"  to pair your Hapty",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white54),
                      ),
                    ],
                  )
                ],
              ),
      ],
    );
  });
}
