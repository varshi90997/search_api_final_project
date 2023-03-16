import 'dart:developer';
import 'package:get/get.dart';
import 'package:search_api/modules/search_model.dart';
import 'package:search_api/modules/search_service.dart';

import '../delet/pagination_model.dart';


class SearchController extends GetxController{

  Rx<ApiModel> apiModel = ApiModel().obs;
  ApiService apiService=ApiService();

  Rx<PaginationModel> paginationModel=PaginationModel().obs;
  RxList l=[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchData();
    await fetchDataFromPagination();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future fetchData() async {
    apiModel.value = await apiService.getUser("");
    log("APIMODEL --------------->${apiModel.value.items?[0].title.toString()}");
  }

  Future fetchDataFromPagination() async {
    paginationModel.value = await apiService.getPagination("");
    log("APIMODEL --------------->${paginationModel.value.results?[0].gender.toString()}");
  }
}