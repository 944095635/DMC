import 'dart:convert';
import 'package:dmc/common/service_result.dart';
import 'package:http/http.dart' as http;

class Http {
  ///* http Get */
  static Future<ServiceResultData> get(String url) async {
    ServiceResultData result = ServiceResultData();
    try {
      var uri = Uri.parse(url);
      var response = await http.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        Map<String, dynamic> obj = json.decode(utf8.decode(response.bodyBytes));
        result.success = true;
        result.data = obj;
      } else {
        result.msg = "networkError";
      }
    } catch (e) {
      result.msg = e.toString();
    }
    return result;
  }

  ///* http post */
  static Future<ServiceResultData> post(
    //Post地址
    String url, {
    //Post数据
    Map? data,
  }) async {
    ServiceResultData result = ServiceResultData();
    try {
      var uri = Uri.parse(url);
      var response = await http
          .post(uri, body: json.encode(data))
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        Map<String, dynamic> obj = json.decode(utf8.decode(response.bodyBytes));
        result.success = true;
        result.data = obj;
      } else {
        result.msg = "networkError";
      }
    } catch (e) {
      result.msg = "networkError";
    }
    return result;
  }

  ///* Token 失效回调 */
  //static Future Function()? whenTokenExpire;

  ///* http Get */
  //static Future<ServiceResultData> get(
  //  String url, {
  //  //临时Token
  //  String? token,
  //}) async {
  //  ServiceResultData result = ServiceResultData();
  //  try {
  //    var uri = Uri.parse("${AppConfig.baseUrl}$url");
  //    var response = await http
  //        .get(uri, headers: getHeaders(token))
  //        .timeout(const Duration(seconds: 15));
  //    if (response.statusCode == 200 && response.body.isNotEmpty) {
  //      Map<String, dynamic> obj = json.decode(utf8.decode(response.bodyBytes));
  //      result.msg = obj['message'];
  //      result.code = obj['code'];
  //      if (obj['code'] == 200) {
  //        result.success = true;
  //        result.data = obj['data'];
  //      } else {
  //        if (!await handlerCode(obj['code'])) {
  //          throw Exception();
  //        }
  //      }
  //    } else {
  //      result.msg = Strings.networkError;
  //    }
  //  } catch (e) {
  //    result.msg = e.toString();
  //  }
  //  return result;
  //}

  ///* http post */
  //static Future<ServiceResultData> post(
  //  //Post地址
  //  String url, {
  //  //Post数据
  //  Map? data,
  //  //临时token
  //  String? token,
  //}) async {
  //  ServiceResultData result = ServiceResultData();
  //  try {
  //    var uri = Uri.parse("${AppConfig.baseUrl}$url");
  //    var response = await http
  //        .post(uri, body: json.encode(data), headers: getHeaders(token))
  //        .timeout(const Duration(seconds: 15));
  //    if (response.statusCode == 200 && response.body.isNotEmpty) {
  //      Map<String, dynamic> obj = json.decode(utf8.decode(response.bodyBytes));
  //      result.msg = obj['message'];
  //      if (obj['code'] == 200) {
  //        result.success = true;
  //        result.data = obj['data'];
  //      } else {
  //        if (!await handlerCode(obj['code'])) {
  //          throw Exception();
  //        }
  //      }
  //    } else {
  //      result.msg = Strings.networkError;
  //    }
  //  } catch (e) {
  //    result.msg = Strings.networkError;
  //  }
  //  return result;
  //}

  ///* 处理非200的状态码 */
  //static Future<bool> handlerCode(int code) async {
  //  //todo 完善此处
  //  //Token失效 比如异地登录等等
  //  if (code == 1006) {
  //    await whenTokenExpire?.call();
  //    return false;
  //  }
  //  return true;
  //}

  //static Future<ServiceResult> upload(
  //  File file, {
  //  String? token,
  //  int fileType = 2,
  //}) async {
  //  ServiceResult result = ServiceResult();
  //  try {
  //    var uri = Uri.parse("${AppConfig.baseUrl}${Urls.uploadImage}");
  //    var request = http.MultipartRequest('POST', uri)
  //      ..fields['fileType'] = fileType.toString()
  //      ..fields['partCount'] = "1"
  //      ..fields['md5'] = "abc"
  //      ..fields['partIndex'] = "0"
  //      ..files.add(
  //        await http.MultipartFile.fromPath(
  //          'file',
  //          file.path,
  //          //contentType: MediaType('application', 'x-tar'),
  //        ),
  //      );
  //    var headers = getHeaders(token);
  //    if (headers != null) {
  //      request.headers.addAll(headers);
  //    }
  //    var response = await request.send().timeout(const Duration(seconds: 99));
  //    //response.stream.transform(utf8.decoder).listen((event) {
  //    //  debugPrint("event:$event");
  //    //});
  //    //if (response.statusCode == 200) {
  //    //}
  //    Stream<String> responseString = response.stream.transform(utf8.decoder);
  //    String jsonCode = await responseString.join();
  //    if (jsonCode.isNotEmpty) {
  //      Map<String, dynamic> obj = json.decode(jsonCode);
  //      result.msg = obj['message'];
  //      result.code = obj['code'];
  //      if (result.code == 200) {
  //        result.success = true;
  //        result.msg = obj['data'];
  //      }
  //    }
  //  } catch (e) {
  //    result.msg = Strings.networkError;
  //  }
  //  return result;
  //}

  ////当前账号的headers
  //static final Map<String, String> _headers = <String, String>{
  //  "content-type": "application/json;charset=utf-8", // charset=utf-8
  //  "deviceNumber": DeviceApi.deviceId,
  //};

  ///// 获取headers
  //static Map<String, String>? getHeaders(String? token) {
  //  if (token != null) {
  //    /// 生成一个临时的Headers
  //    return <String, String>{
  //      "Authorization": token,
  //      "deviceNumber": DeviceApi.deviceId,
  //      "content-type": "application/json;charset=utf-8"
  //    };
  //  } else {
  //    return _headers;
  //  }
  //}

  //static void removeToken() {
  //  _headers.remove("Authorization");
  //}

  //static void addToken(String token) {
  //  _headers.addAll({"Authorization": token});
  //}

  ///// 下载文件
  //static void download(
  //  String link,
  //  String localPath,
  //  Function(int received, int total) callback,
  //  Function downloadOK, {
  //  bool override = false,
  //}) async {
  //  var file = File(localPath);
  //  if (file.existsSync()) {
  //    if (override) {
  //      file.deleteSync();
  //    } else {
  //      //本地文件存在，暂时不检查完整性
  //      downloadOK.call();
  //      return;
  //    }
  //  }

  //  var url = Uri.parse("${AppConfig.baseUrl}$link");
  //  var response = await http.Client().send(http.Request('GET', url));
  //  int total = 0, received = 0;
  //  total = response.contentLength ?? 0;
  //  final List<int> bytes = [];
  //  response.stream.listen((value) {
  //    bytes.addAll(value);
  //    received += value.length;
  //    callback.call(received, total);
  //  }).onDone(() async {
  //    await file.writeAsBytes(bytes);
  //    downloadOK.call();
  //  });
  //}
}
