// custom back button
import 'package:flutter/material.dart';

Widget customBackButton(BuildContext context, Color color) {
  return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Icons.cancel,
        color: color,
      ));
}
