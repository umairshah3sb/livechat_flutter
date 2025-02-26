import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livechat/utils/colors.dart';

Widget TitleWidget() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'L',
        style: GoogleFonts.portLligatSans(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: orange,
        ),
        children: [
          TextSpan(
            text: '!',
            style: TextStyle(color: black, fontSize: 30),
          ),
          TextSpan(
            text: 've',
            style: TextStyle(color: orange, fontSize: 30),
          ),
          TextSpan(
            text: 'chat',
            style: TextStyle(color: black, fontSize: 30),
          ),
        ]),
  );
}
