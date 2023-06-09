import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:search_api/modules/search_controller.dart';
import 'package:search_api/modules/search_model.dart';
import '../../api/api.dart';
import 'package:http/http.dart' as http;


class ApiService{
  // Future<ApiModel> getUser() async{
  //   final response = await http.get(Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=dc59cf7e953a49e98ad36ae8ae5bfb50'));
  //   log("RESPONSE BODY : ${response.body}");
  //   if(response.statusCode == 200){
  //     return ApiModel.fromJson(json.decode(response.body));
  //   }
  //   return ApiModel();
  // }
  RxString byDefault = "".obs;


  Future<ApiModel> getUser({String? name}) async {
    try {
      final response = await Api().post("https://yeay-dev.xc.io/search",
          bodyData: {
            "pageIndex": 1,
            "searchText": name.toString()=="null"?byDefault.value:name.toString(),
            "returnedRecords": 20
          });

      log("RESPONSE BODY---------------------->: ${response.body}");
      log("string ---------------------->: ${name.toString()}");

      return ApiModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
