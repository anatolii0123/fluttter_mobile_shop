import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url) {
    return http.get(Uri.parse(url)).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {Map<String, String>? headers, body, encoding}) {
    return http.post(Uri.parse(url), body: body, headers: headers, encoding: encoding).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> postFile(String url, String key, File imageFile, {Map<String, String>? headers, body, encoding}) async {
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri)
      ..fields.addAll(body)
      ..files.add(await http.MultipartFile.fromPath(key, imageFile.path, contentType: encoding));
    var response = await request.send();
    final String res = response.reasonPhrase ?? '';
    final int statusCode = response.statusCode;
    print('statusCode $statusCode');
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    print('Uploaded $res');
    return _decoder.convert(res);
  }

  Future<dynamic> postImage(
    String url,
    String key,
    File imageFile,
  ) async {
    Response response;
    Dio dio = new Dio();
    var formData = FormData.fromMap({
      "name": "wendux",
      "age": 25,
      key: await MultipartFile.fromFile(imageFile.path, filename: "upload.png"),
    });
    response = await dio.post(url, data: formData);
  }
}
