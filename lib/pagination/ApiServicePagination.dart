import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../pagination/user_model.dart';
import 'package:http/http.dart' as http;


class ApiServicePagination{

  RxString byDefault = " ".obs;

  static Future<UserModel> getUserData({int? page}) async {
    try {
      log("service:::::::::::::::::>>>>>${page}");
      var response = await http.get(Uri.parse("https://randomuser.me/api/?page=$page&results=10&seed=abc"),);
      print(response.body);
      print("Status code=============>${response.statusCode}");
      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(jsonDecode(response.body));

        return userModel;
      }
    } catch (e, st) {
      print("ERROR::::::$e , st $st");
    }
    return UserModel(info: Info(seed: "", results: 0, page: 0, version: ""), results: []);
  }

}
