import 'package:flutter/material.dart';

import '../data/preferences.dart';
import '../data/variables.dart';
import 'globals_methods.dart';

PageController pageViewController = PageController(initialPage: lastPage);

// Method to change pageview on horizontal swipes
void changePageViewOnSwipe(DragEndDetails drag) {
  if (drag.primaryVelocity == null) return;
  if (drag.primaryVelocity! < -300) {
    print(drag.primaryVelocity);
    // drag from right to left
    if (pageViewController.page!.toInt() >= 0 && pageViewController.page!.toInt() < 4) {
      prefs.setInt("lastPage", pageViewController.page!.toInt() + 1);
      globalWatch.updateSelectedPage(pageViewController.page!.toInt() + 1);
      pageViewController.jumpToPage(pageViewController.page!.toInt() + 1);
    }
  }
  if (drag.primaryVelocity! > 300) {
    print(drag.primaryVelocity);
    // drag from left to right
    if (pageViewController.page!.toInt() > 0 && pageViewController.page!.toInt() <= 4) {
      prefs.setInt("lastPage", pageViewController.page!.toInt() - 1);
      globalWatch.updateSelectedPage(pageViewController.page!.toInt() - 1);
      pageViewController.jumpToPage(pageViewController.page!.toInt() - 1);
    }
  }
}
