import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:livechat/model/user_model.dart';
import 'package:livechat/screen/auth/register.dart';
import 'package:livechat/screen/chat/singlechat/chat_list_screen.dart';
import 'package:livechat/utils/colors.dart';
import 'package:livechat/utils/constant.dart';
import 'package:livechat/utils/keys.dart';
import 'package:livechat/utils/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().initStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: orange,
                ),
              );
            } else if (snap.hasError) {
              return SignUpPage();
            } else if (snap.hasData) {
              String? tempToken =
                  snap.data!.getString(StaticKeys.loginUserTokenKey);
              if (tempToken != null) {
                token = tempToken;
                String userData = snap.data!.getString(StaticKeys.loginKey)!;
                user = UserModel.fromJson(jsonDecode(userData));
                return WelcomePage();
              }
              return SignUpPage();
            }
            return SignUpPage();
          }),
    );
  }
}
