import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:livechat/screen/auth/login.dart';
import 'package:livechat/screen/auth/register.dart';
import 'package:livechat/screen/chat/singlechat/conversation_screen.dart';
import 'package:livechat/utils/colors.dart';
import 'package:livechat/utils/helper.dart';
import 'package:livechat/widget/title_widget.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
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
                    children: List.generate(
                      15,
                      (i) {
                        return InkWell(
                          onTap: () {
                            pushRoute(ConversationScreen());
                          },
                          child: ChatListItem(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container ChatListItem() {
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
            foregroundImage: AssetImage('assets/img/profile.jpeg'),
          ),
          gap(w: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The Code Pie',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.done,
                    size: 16,
                    color: black,
                  ),
                  gap(w: 5),
                  Text(
                    'Hi how are you bro?',
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
            '12:12 pm',
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
          Icon(
            Icons.more_vert,
            color: black,
            size: 24,
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
