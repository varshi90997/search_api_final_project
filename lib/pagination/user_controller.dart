import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:search_api/pagination/user_model.dart';

import '../modules/search_model.dart';
import 'ApiServicePagination.dart';
import 'de_bouncer/debouncer.dart';

class UserController extends GetxController {

  final DeBouncer _deBouncer = DeBouncer();
  ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  RxList userList = [].obs;
  RxBool isPaginationLoading = false.obs;

  Rx<UserModel> userModel = UserModel().obs;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    getData(page.value);/// {{1}} add only 1 page data userList
    pagination();///  {{2}} add 2,3++ all page data in userList
    super.onInit();
  }


  void pagination() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {///-------> {{3}} for scroll controller
        await _deBouncer.run(() async {
          page++;
          log("****************${page.value}");
          isPaginationLoading.value = true;///-------> {{4}} for loader true---->when true show circular progress indicator show
          await fetchMoreData(page.value);///-------> {{5}} for fetchData pass page number
        });
      }
    });
  }

  Future fetchMoreData(int page) async {
    try {
      print("---------Api Called");
      userModel.value = await ApiServicePagination.getUserData(page: page);///-------> {{6}} call api
      for (var i in userModel.value.results!) {///-------> {{7}} for add result data in userList
        userList.add(i);
      }
      print("===============${userModel.value}");
      isPaginationLoading.value = false;///-------->{{8}} for loader true---->when false show data
    } catch (e, st) {
      print("ERROR:::::::$e  $st");
    }
  }


  Future getData(int page) async {
    try {
      isLoading.value = true;//-------> {{1}} for loader
      print("---------Api Called");
      userModel.value = await ApiServicePagination.getUserData(page:page);//-------> {{2}} call api
      for (var i in userModel.value.results!) {//-------> {{3}} for add result only first page data in userList
        userList.add(i);
      }
      print("===============${userModel.value}");
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
      print("ERROR:::::::$e  $st");
    }
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return " ${(diff.inDays / 365).floor() == 1 ? "1 Year Ago" : DateFormat('yMMMMd').format(d)}";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor() == 1
          ? "month"
          : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor() == 1
          ? "week"
          : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays == 1 ? "Yesterday,${DateFormat("hh : mm")}" : "${(diff.inDays / 7).floor()} days"} ago";
    }

    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1
          ? "minute"
          : "minutes"} ago";
    }
    return "just now";
  }
}