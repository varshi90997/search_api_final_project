import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:search_api/const/const.dart';

import 'logger_Interceptor.dart';

Future<Map<String, String>> headers() async {
  final Map<String, String> headers = <String, String>{};
  // headers["Authorization"] = "Basic Y3JpYzM2MGRldmxpdmU6Y0g0YkhzZ3hubkNoODVKclVnOGo=";
  // headers["Platform"] = "2";
  // headers["Version"] = "15.4";

  return headers;
}

class Api {
  static Api? _instance;

  static http.Client get dio => InterceptedClient.build(
    interceptors: [
      LoggerInterceptor(),
    ],
  );

  factory Api() {
    if (_instance == null) {
      _instance = Api._();
      return _instance!;
    } else {
      return _instance!;
    }
  }

  Api._();

  Future<http.Response> post(
      String url, {
        Map<String, dynamic>? queryData,
        Map<String, dynamic>? bodyData,
      }) async {
    log("post ${await headers()}}");
    final response = await dio.post(
      Uri.parse(url),
      body: jsonEncode(bodyData),
      headers: {"Content-Type" : "application/json"},
    );
    return response;
  }

  Future<http.Response> put(
      String url, {
        Map<String, dynamic>? queryData,
        Map<String, dynamic>? bodyData,
      }) async {
    // log("put ${await headers()}}");
    final response = await dio.put(
      getUrl(url, queryParameters: queryData),
      body: jsonEncode(bodyData),
      // headers: await headers(),
    );
    return response;
  }

  Future<http.Response> patch(
      String url, {
        Map<String, dynamic>? queryData,
        Map<String, dynamic>? bodyData,
      }) async {
    final response = await dio.patch(
      getUrl(url, queryParameters: queryData),
      body: jsonEncode(bodyData),
      headers: await headers(),
    );
    return response;
  }

  Future<http.Response> delete(
      String url, {
        Map<String, dynamic>? queryData,
        Map<String, dynamic>? bodyData,
      }) async {
    final response = await dio.delete(
      getUrl(url, queryParameters: queryData),
      body: jsonEncode(bodyData),
      headers: await headers(),
    );
    return response;
  }

  Future<http.Response> head(
      String url, {
        Map<String, dynamic>? queryData,
      }) async {
    final response = await dio.head(
      getUrl(url, queryParameters: queryData),
      headers: await headers(),
    );
    return response;
  }

  Future<http.Response> get(
      String url,{
        Map<String, dynamic>? queryData,
      }) async {
    log("get ${await headers()}}");
    final response = await dio.get(getUrl(url, queryParameters: queryData),
      headers: await headers(),
    );
    return response;
  }


  Future<http.Response> getOtherUrl(
      String url, {
        Map<String, dynamic>? queryData,
      }) async {
    log("get ${await headers()}}");
    log(Uri.parse(url).toString());
    final response = await dio.get(
      Uri.parse(url),
      headers: {"Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NzUxNjc4MzZ9.KEVdFX-oM1JGbQ6diZaJTDoWLvsU5dZVjo5gf5DFEtM"},
    );
    return response;
  }
  // Future<http.Response> getStorageApi(
  //     String url, {
  //       Map<String, dynamic>? queryData,
  //     }) async {
  //   log("get ${await headers()}}");
  //   final response = await dio.get(
  //     getStorageUrl(url, queryParameters: queryData),
  //     headers: await headers(),
  //   );
  //   return response;
  // }
}

Uri getUrl(String endpoint, {Map<String, dynamic>? queryParameters}) {
  String url = "${ApiConstants.BASE_URL}$endpoint";
  if (queryParameters != null && queryParameters.isNotEmpty) {
    url = "$url?";
    for (int i = 0; i < queryParameters.entries.length; i++) {
      final element = queryParameters.entries.elementAt(i);
      url += '${element.key}=${element.value}';
      if (i < queryParameters.entries.length - 1) {
        url += '&';
      }
    }
  }
  log(Uri.parse(url).toString());
  return Uri.parse(url);
}

// Uri getStorageUrl(String endpoint, {Map<String, dynamic>? queryParameters}) {
//   String url = "${ApiConstants.API_STORAGE_BASE_URL}$endpoint";
//   if (queryParameters != null && queryParameters.isNotEmpty) {
//     url = "$url?";
//     for (int i = 0; i < queryParameters.entries.length; i++) {
//       final element = queryParameters.entries.elementAt(i);
//       url += '${element.key}=${element.value}';
//       if (i < queryParameters.entries.length - 1) {
//         url += '&';
//       }
//     }
//   }
//   log(Uri.parse(url).toString());
//   return Uri.parse(url);
// }

Uri parseUrl(String url) {
  log(Uri.parse(url).toString());
  return Uri.parse(url);
}
