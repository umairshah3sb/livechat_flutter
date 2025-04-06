import 'package:flutter/material.dart';

import 'package:livechat/model/message_model.dart';
import 'package:livechat/screen/chat/controller/chatController.dart';
import 'package:livechat/utils/exporter.dart';
import 'package:livechat/utils/helper.dart';

class MyTextMessage extends StatefulWidget {
  MessageModel message;
  MyTextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  State<MyTextMessage> createState() => _MyTextMessageState();
}

class _MyTextMessageState extends State<MyTextMessage> {
  ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerRight,
      child: Stack(
        children: [
          Container(
            padding: spacOnly(top: 7, left: 7, right: 7, bottom: 3),
            margin: spacOnly(
              right: 25,
              top: 5,
              bottom: 5,
              left: 50,
            ),
            decoration: BoxDecoration(
              color: white,
              borderRadius: radiusOnly(
                topLeft: 10,
                topRight: 10,
                bottomLeft: 10,
              ),
              boxShadow: glassShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You',
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        color: black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    gap(h: 2),
                    Text(
                      widget.message.message,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    gap(h: 5),
                  ],
                ),
                Text(
                  messageSendTime(widget.message.sendTime),
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    color: black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 5,
            bottom: 0,
            child: Icon(
              Icons.done,
              color: black,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
