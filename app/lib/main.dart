import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/preferences.dart';
import 'methods/globals_methods.dart';
import 'state/alarms_state.dart';
import 'state/ble_state.dart';
import 'state/global_state.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/theme/theme.dart';
import 'ui/widgets/loading_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // get and set shared preference instance globally
  prefs = await SharedPreferences.getInstance();

  // know if it's the first time running app
  // bool firstTime = await prefs.getBool("firstTime");
  bool firstTime = false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GlobalModel()),
        ChangeNotifierProvider(create: (context) => BleModel()),
        ChangeNotifierProvider(create: (context) => AlarmModel()),
      ],
      child: MyApp(
        firstTime: firstTime,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.firstTime, super.key});

  final bool firstTime;

  @override
  Widget build(BuildContext context) {
    // create syntax-shortcut variables that point to the respective provider funcions
    createProviderReferences(context: context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hapty',
      theme: appTheme,
      home: HomeScreen(),
      // home: firstTime ? HomeScreen() : WelcomeScreen(),
      builder: (context, child) {
        return Stack(
          children: [child!, loadingWidget(context)],
        );
      },
    );
  }
}
