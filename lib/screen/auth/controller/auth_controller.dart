import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livechat/api/api.dart';
import 'package:livechat/model/user_model.dart';
import 'package:livechat/screen/auth/login.dart';
import 'package:livechat/screen/home/home.dart';
import 'package:livechat/utils/config.dart';
import 'package:livechat/utils/constant.dart';
import 'package:livechat/utils/helper.dart';
import 'package:livechat/utils/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  Future<void> registerUser() async {
    isLoading = true;
    update();
    if (phone.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        username.text.isNotEmpty) {
      final response = await API().postRequest(
        data: {
          'username': username.text.trim(),
          'phone': phone.text.trim(),
          'email': email.text.trim(),
          'password': password.text.trim(),
        },
        route: CONFIG.registerRoute,
      );

      if (response['status'] == '200') {
        showToast(response['message']);
        Timer(Duration(seconds: 2), () {
          pushRoute(LoginPage());
        });
      } else {
        showToast(response['message']);
      }
    } else {
      showToast('Please enter all the fields!');
    }
    email.text = '';
    phone.text = '';
    username.text = '';
    password.text = '';

    isLoading = false;
    update();
  }

  Future<void> loginUser() async {
    isLoading = true;
    update();
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      final response = await API().postRequest(
        data: {
          'email': email.text.trim(),
          'password': password.text.trim(),
        },
        route: CONFIG.loginRoute,
      );

      if (response['status'] == '200') {
        final pref = await SharedPreferences.getInstance();
        await pref.setString(StaticKeys.loginUserTokenKey, response['token']);
        await pref.setString(StaticKeys.loginKey, jsonEncode(response['user']));
        showToast(response['message']);
        token = response['token'];
        user = UserModel.fromJson(response['user']);
        Timer(Duration(seconds: 2), () {
          pushRoute(WelcomePage());
        });
      } else {
        showToast(response['message']);
      }
    } else {
      showToast('Please enter all the fields!');
    }
    email.text = '';
    password.text = '';
    isLoading = false;
    update();
  }
}
