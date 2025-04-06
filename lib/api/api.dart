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
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('${CONFIG.apiURL}$route'));
      request.fields.addAll(mapData);
      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        'Authorization': 'bearer $token',
      });
      for (var path in paths) {
        request.files.add(await http.MultipartFile.fromPath(fileKey, path));
      }

      http.StreamedResponse response = await request.send();
      final result = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(result);
      } else {
        print('--------------------------------');
        print(response.reasonPhrase);
        print(result);
      }
    } catch (e) {
      return null;
    }
  }
}
