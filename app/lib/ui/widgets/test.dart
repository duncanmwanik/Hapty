import 'package:flutter/material.dart';
import '../../models/alarm_model.dart';
import '../theme/theme.dart';
import 'back_button.dart';

// ignore: must_be_immutable
class TestScreen extends StatefulWidget {
  TestScreen({super.key, required this.test});

  TestObject test;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: customBackButton(context, Colors.white),
        title: Text(
          "Test Screen",
          style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            padding: EdgeInsets.all(50),
            decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            child: Text(
              "a: ${widget.test.a} | b: ${widget.test.b}",
              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
            decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Change Values",
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                       setState(() {
                         widget.test.a++;
                       });
                        print(widget.test.a);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text(
                        "A",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.test.b++;
                        });
                        print(widget.test.b);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text(
                        "B",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
