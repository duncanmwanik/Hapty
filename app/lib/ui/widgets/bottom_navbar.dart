import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../data/preferences.dart';
import '../../methods/globals_methods.dart';
import '../../methods/navigation_methods.dart';
import '../screens/alarm_actions/add_alarm_screen.dart';
import '../theme/theme.dart';

Widget bottomNavbar(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: [
      Visibility(
        visible: globalWatch.selectedTab == 0,
        child: FloatingActionButton(
          heroTag: null,
          onPressed: () {
            alarmWatch.resetAlarm();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAlarmScreen(),
              ),
            );
          },
          backgroundColor: themeColor,
          child: Icon(Icons.add),
        ),
      ),
      FloatingNavbar(
        onTap: (int page) {
          prefs.setInt("lastPage", page);
          globalWatch.updateSelectedTab(page);
          globalWatch.updateSelectedPage(page);
          pageViewController.jumpToPage(page);
        },
        elevation: 0,
        backgroundColor: secondaryColor,
        selectedBackgroundColor: Colors.black26,
        selectedItemColor: Colors.red,
        borderRadius: borderRadius,
        itemBorderRadius: borderRadius,
        fontSize: 13,
        iconSize: 26,
        currentIndex: globalWatch.selectedTab,
        items: [
          FloatingNavbarItem(icon: Icons.cloud_circle),
          FloatingNavbarItem(icon: Icons.explore),
          FloatingNavbarItem(icon: Icons.settings),
        ],
      ),
    ],
  );
}
