import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../methods/ble_methods.dart';
import '../../../methods/globals_methods.dart';
import '../../../methods/navigation_methods.dart';
import '../../../state/global_state.dart';
import '../../theme/theme.dart';
import '../../widgets/bottom_navbar.dart';
import '../../widgets/toast.dart';
import 'pageviews/alarms_page.dart';
import 'pageviews/devices_page.dart';
import 'pageviews/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();

    // listen for changes in Bluetooth state
    FlutterBluePlus.instance.state.listen((event) {
      if (event == BluetoothState.on) {
        bleWatch.updateBtState(true);
      } else if (event == BluetoothState.off) {
        toast(0, "Bluetooth is off!");
        bleWatch.updateBtState(false);
        bleWatch.setDevice(null);
        bleWatch.setConnectionState(false);
      }
    });

    checkAlreadyConnectedDevices();
  }

  @override
  Widget build(BuildContext context) {
    // get device screen size and save them globally
    getDeviceSize(context);

    return GestureDetector(
      onHorizontalDragEnd: (details) => swipe(details),
      child: Scaffold(
        extendBody: true,
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          title: Image(height: 30, fit: BoxFit.contain, image: AssetImage("assets/images/logo.png")),
        ),
        body: Consumer<GlobalModel>(builder: (context, g, child) {
          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ExpandablePageView(
                  controller: pageViewController,
                  pageSnapping: false,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    alarmsPageView(context),
                    devicesPageView(context),
                    settingsPageView(context),
                  ]),
            ],
          );
        }),
        // -------------------- Bottom navigation bar
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: bottomNavbar(context),
      ),
    );
  }
}
