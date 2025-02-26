import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:livechat/utils/config.dart';
import 'package:livechat/utils/constant.dart';

class API {
  Future<dynamic> postRequest(
      {required Map<String, String> data, required String route}) async {
    final response = await http.post(Uri.parse('${CONFIG.apiURL}$route'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'Application/json',
          'Authorization': 'bearer $token',
        });
    return jsonDecode(response.body);
  }
}
