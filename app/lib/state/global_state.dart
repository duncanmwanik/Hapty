// --------------------------------- GLOBALS ---------------------------------
// all other variables, methods and providers

import 'package:flutter/material.dart';
import '../data/preferences.dart';
import '../methods/datetime_methods.dart';

class GlobalModel with ChangeNotifier {
  // ---------- bottom nav bar
  int selectedTab = 1;

  void updateSelectedTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  // ---------- pageview
  int selectedPage = prefs.getInt("lastPage") ?? 1;

  void updateSelectedPage(int selected) {
    selectedPage = selected;
    notifyListeners();
  }

  // ---------- dates
  int selectedDate = getCurrentWeekDay();

  void updateSelectedDate(int day) {
    selectedDate = day;
    notifyListeners();
  }

  final List<DateTime> _currentWeekDates = getCurrentWeekDates();

  List<DateTime> get currentWeekDates {
    return _currentWeekDates;
  }

  // ---------- loading screen
  bool showLoading = false;

  void showLoadingScreen(bool show) {
    showLoading = show;
    notifyListeners();
  }
}
