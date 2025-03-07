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

  Future<dynamic> multipartRequest({
    required String route,
    required Map<String, String> mapData,
    required String fileKey,
    required List<String> paths,
  }) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('${CONFIG.apiURL}$route'));
    request.fields.addAll(mapData);
    for (var path in paths) {
      request.files.add(await http.MultipartFile.fromPath(fileKey, path));
    }
    http.StreamedResponse response = await request.send();
    final result = await response.stream.bytesToString();
    return jsonDecode(result);
  }
}
