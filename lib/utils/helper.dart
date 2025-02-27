import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:livechat/utils/colors.dart';

pushRoute(Widget screen) {
  Navigator.of(Get.context!).push(
    MaterialPageRoute(builder: (context) => screen),
  );
}

showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: orange,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

SizedBox gap({double w = 0, double h = 0}) {
  return SizedBox(
    width: w,
    height: h,
  );
}

EdgeInsets spacing({double h = 0, double v = 0}) {
  return EdgeInsets.symmetric(horizontal: h, vertical: v);
}

EdgeInsets spacOnly(
    {double left = 0, double right = 0, double top = 0, double bottom = 0}) {
  return EdgeInsets.only(
    top: top,
    left: left,
    right: right,
    bottom: bottom,
  );
}

BorderRadius circularRadius(double radius) {
  return BorderRadius.circular(radius);
}

BorderRadius radiusOnly(
    {double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0}) {
  return BorderRadius.only(
    topLeft: Radius.circular(topLeft),
    topRight: Radius.circular(topRight),
    bottomLeft: Radius.circular(bottomLeft),
    bottomRight: Radius.circular(bottomRight),
  );
}

List<BoxShadow> newShadow = [
  BoxShadow(
    color: Colors.grey.shade600,
    spreadRadius: 1,
    blurRadius: 15,
    offset: const Offset(5, 5),
  ),
  const BoxShadow(
      color: Colors.white,
      offset: Offset(-5, -5),
      blurRadius: 15,
      spreadRadius: 1),
];

List<BoxShadow> shadow = [
  BoxShadow(
    offset: Offset.zero,
    color: Color.fromARGB(40, 0, 0, 0),
    blurRadius: 30,
    spreadRadius: 1,
    blurStyle: BlurStyle.outer,
  ),
];
List<BoxShadow> glassShadow = [
  BoxShadow(
    color: Color(0x26442A7C),
    blurRadius: 28.68,
    offset: Offset(0, 28.68),
    spreadRadius: 0,
  ),
  BoxShadow(
    color: Color(0x26442A7C),
    blurRadius: 28.68,
    offset: Offset(0, 28.68),
    spreadRadius: 0,
  )
];

pop() {
  Navigator.of(Get.context!).pop();
}
