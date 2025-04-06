import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:livechat/model/chat_list_model.dart';
import 'package:livechat/model/user_model.dart';
import 'package:livechat/screen/auth/login.dart';
import 'package:livechat/screen/auth/register.dart';
import 'package:livechat/screen/chat/controller/chat_list_controller.dart';
import 'package:livechat/screen/chat/singlechat/conversation_screen.dart';
import 'package:livechat/utils/colors.dart';
import 'package:livechat/utils/constant.dart';
import 'package:livechat/utils/helper.dart';
import 'package:livechat/widget/title_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  ChatListController controller = Get.put(ChatListController());

  @override
  void initState() {
    getChatList();
    super.initState();
  }

  Future<void> getChatList() async {
    await controller.getChatList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: controller.isLoading
            ? loadingSpinner()
            : Container(
                width: Get.width,
                height: Get.height,
                child: Column(
                  children: [
                    ChatHeader(),
                    SearchBar(),
                    gap(h: 15),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: spacOnly(
                          bottom: 30,
                        ),
                        child: Column(
                          children: controller.chatList.map((chat) {
                            return InkWell(
                              onTap: () {
                                pushRoute(ConversationScreen(
                                  userId: chat.userId == user.id.toString()
                                      ? chat.recId
                                      : chat.userId,
                                ));
                              },
                              child: ChatListItem(chat),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Container ChatListItem(ChatListModel chat) {
    print('${user.id}-------------------------------');
    UserModel recProfile =
        chat.userId == user.id.toString ? chat.recProfile : chat.userProfile;
    return Container(
      margin: spacing(h: 10, v: 3),
      padding: spacing(h: 10, v: 5),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(
          width: 0.5,
          color: black,
        ),
        borderRadius: radiusOnly(
          topLeft: 10,
          topRight: 10,
          bottomLeft: 10,
        ),
        boxShadow: glassShadow,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            foregroundImage: NetworkImage(
              recProfile.avatar != null
                  ? recProfile.avatar!
                  : recProfile.profilePhotoUrl!,
            ),
          ),
          gap(w: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recProfile.username,
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  chat.seenTime != null
                      ? Icon(
                          Icons.done_all,
                          size: 16,
                          color: orange,
                        )
                      : chat.receivedTime != null
                          ? Icon(
                              Icons.done_all,
                              size: 16,
                              color: black,
                            )
                          : Icon(
                              Icons.done,
                              size: 16,
                              color: black,
                            ),
                  gap(w: 5),
                  Text(
                    chat.message,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Text(
            messageSendTime(chat.sendTime),
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: black,
              fontWeight: FontWeight.w500,
            ),
          ),
          gap(w: 15),
        ],
      ),
    );
  }

  Container ChatHeader() {
    return Container(
      margin: spacing(h: 10, v: 10),
      child: Row(
        children: [
          TitleWidget(),
          Spacer(),
          Icon(
            Icons.camera_alt_outlined,
            color: black,
            size: 24,
          ),
          gap(w: 10),
          InkWell(
            onTap: () async {
              final pref = await SharedPreferences.getInstance();
              await pref.clear();
              pushRoute(LoginPage());
            },
            child: Icon(
              Icons.more_vert,
              color: black,
              size: 24,
            ),
          ),
          gap(w: 10),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: spacing(h: 25),
      padding: spacing(h: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: black,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: glassShadow,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
          hintStyle: TextStyle(
            fontSize: 18,
            color: black,
            fontWeight: FontWeight.w700,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: black,
            size: 30,
          ),
          contentPadding: spacOnly(top: 10),
        ),
      ),
    );
  }
}
