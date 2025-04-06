import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:livechat/model/message_model.dart';
import 'package:livechat/screen/chat/controller/chatController.dart';
import 'package:livechat/utils/exporter.dart';
import 'package:livechat/utils/helper.dart';

class MyImageMessage extends StatefulWidget {
  MessageModel message;
  MyImageMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  State<MyImageMessage> createState() => _MyImageMessageState();
}

class _MyImageMessageState extends State<MyImageMessage> {
  ChatController controller = Get.put(ChatController());
  List<String> images = [];
  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() {
    List<dynamic> files = jsonDecode(widget.message.files);
    for (var image in files) {
      images.add(getFullLink(image.toString()));
    }
    print(images);
  }

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
                    gap(h: 5),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: images.length > 1 ? 2 : 1,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                        childAspectRatio: 1,
                      ),
                      itemCount: images.length > 4 ? 4 : images.length,
                      itemBuilder: (context, i) {
                        return Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: circularRadius(10),
                                child: Image.network(
                                  images[i],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            images.length > 4 && i == 3
                                ? Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Center(
                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: black.withAlpha(100),
                                          borderRadius: circularRadius(50),
                                        ),
                                        child: Text(
                                          '+${images.length - 4}',
                                          style: GoogleFonts.manrope(
                                            fontSize: 25,
                                            color: white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                : gap(),
                          ],
                        );
                      },
                    ),
                    gap(h: 5),
                    Text(
                      widget.message.message,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
