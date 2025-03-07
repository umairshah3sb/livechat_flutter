import 'dart:convert';

import 'package:livechat/api/api.dart';
import 'package:livechat/model/message_model.dart';
import 'package:livechat/model/user_model.dart';
import 'package:livechat/utils/config.dart';
import 'package:livechat/utils/constant.dart';
import 'package:livechat/utils/exporter.dart';
import 'package:livechat/utils/keys.dart';
import 'package:livechat/utils/storage_service.dart';

class ChatController extends GetxController {
  String userId = '';
  UserModel? recProfile;
  List<MessageModel> chat = [];
  bool isLoading = false;
  StorageService store = StorageService();
  Future<void> getUser() async {
    isLoading = true;
    update();
    String? data = store.readData(key: '${StaticKeys.chatUserKey}${userId}');
    if (data != null) {
      recProfile = UserModel.fromJson(jsonDecode(data));
    }
    if (recProfile == null) {
      final response = await API().postRequest(
        data: {'user_id': userId},
        route: CONFIG.getUserRoute,
      );
      if (response['status'].toString() == '200') {
        store.writeData(
          key: '${StaticKeys.chatUserKey}${userId}',
          data: jsonEncode(response['user']),
        );
        recProfile = UserModel.fromJson(response['user']);
      }
    }
  }

  getChat() async {
    final response = await API().postRequest(data: {
      'user_id': user.id.toString(),
      'rec_id': userId,
    }, route: CONFIG.getChatRoute);
    if (response['status'].toString() == '200') {
      chat = [];
      for (var message in response['data']) {
        chat.add(MessageModel.fromJson(message));
      }
    }
    isLoading = false;
    update();
  }
}
