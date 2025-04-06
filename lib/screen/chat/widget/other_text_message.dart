import 'package:flutter/material.dart';

import 'package:livechat/model/message_model.dart';
import 'package:livechat/screen/chat/controller/chatController.dart';
import 'package:livechat/utils/exporter.dart';
import 'package:livechat/utils/helper.dart';

class OtherTextMessage extends StatefulWidget {
  MessageModel message;
  OtherTextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  State<OtherTextMessage> createState() => _OtherTextMessageState();
}

class _OtherTextMessageState extends State<OtherTextMessage> {
  ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          Container(
            padding: spacOnly(top: 7, left: 7, right: 7, bottom: 3),
            margin: spacOnly(
              left: 10,
              top: 5,
              bottom: 5,
              right: 50,
            ),
            decoration: BoxDecoration(
              color: black,
              borderRadius: radiusOnly(
                topLeft: 10,
                topRight: 10,
                bottomRight: 10,
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
                      controller.recProfile!.username,
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        color: white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    gap(h: 3),
                    Text(
                      widget.message.message,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: white,
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
                    color: white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
