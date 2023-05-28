import 'package:flutter/material.dart';

import '../../../../methods/globals_methods.dart';
import '../../../theme/theme.dart';

Widget settingsPageView(BuildContext context) {
  Widget divider() {
    return Divider(
      height: 0,
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
    );
  }

  Widget leadingText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w400),
    );
  }

  Widget trailingText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
    );
  }

  return ListView(
    shrinkWrap: true,
    physics: BouncingScrollPhysics(),
    children: [
      Image(width: w * 0.5, height: w * 0.5, image: AssetImage("assets/images/logo.png")),

      // ********************************* GENERAL
      ListTile(tileColor: primaryColor, leading: titleText("GENERAL")),
      divider(),

      divider(),
      // ********************************* SUPPORT
      ListTile(tileColor: primaryColor, leading: titleText("SUPPORT")),
      divider(),
      ListTile(
        tileColor: secondaryColor,
        leading: leadingText('About Application'),
      ),
      divider(),
      ListTile(
        tileColor: secondaryColor,
        leading: leadingText('Send Feedback'),
      ),
      divider(),
      ListTile(
        tileColor: secondaryColor,
        leading: leadingText('App Version'),
        trailing: trailingText('v1.0'),
      ),
      divider(),
      divider(),
    ],
  );
}
