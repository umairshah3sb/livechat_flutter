import 'dart:convert';

import 'package:livechat/api/api.dart';
import 'package:livechat/model/chat_list_model.dart';
import 'package:livechat/utils/config.dart';
import 'package:livechat/utils/constant.dart';
import 'package:livechat/utils/exporter.dart';
import 'package:livechat/utils/keys.dart';
import 'package:livechat/utils/storage_service.dart';

class ChatListController extends GetxController {
  List<ChatListModel> chatList = [];
  bool isLoading = false;
  StorageService store = StorageService();
  @override
  void onInit() {
    getChatList();
    super.onInit();
  }

  getChatList() async {
    isLoading = true;
    update();
    chatList = [];
    String? data = store.readData(key: StaticKeys.chatListKey);
    if (data != null) {
      List<dynamic> chatlist = jsonDecode(data);
      for (var chat in chatlist) {
        chatList.add(ChatListModel.fromJson(chat));
      }
      isLoading = false;
      update();
    }
    final response = await API().postRequest(data: {
      'user_id': user.id.toString(),
    }, route: CONFIG.chatListRoute);

    if (response['status'].toString() == '200') {
      await store.writeData(
        key: StaticKeys.chatListKey,
        data: jsonEncode(response['data']),
      );
      chatList = [];
      for (var chat in response['data']) {
        chatList.add(ChatListModel.fromJson(chat));
      }
    }

    isLoading = true;
    update();
  }
}
