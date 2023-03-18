import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_api/modules/search_model.dart';
import 'package:search_api/modules/search_service.dart';


class SearchController extends GetxController{

  Rx<ApiModel> apiModel = ApiModel().obs;
  ApiService apiService=ApiService();

  RxList<File> imageList = <File>[].obs;
  RxString imageFile="".obs;
  String imageFileSt="";

  RxBool loader=true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchData();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }


  pickImageFromGallery(int index) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
       imageFile.value = pickedFile.path;
       print("-==-----$imageFile");
       imageFileSt=imageFile.value;

       apiModel.value.items?[index].thumbnailUrl = imageFile.value;
       apiModel.value.items?[index].image = imageFile.value;

       log("========== this is ok=====>${apiModel.value.items?[index].thumbnailUrl.toString()}");
       log(index.toString());
       // imageList.add(imageFile.value!);

    }
    return true;
  }

  pickImageFromCamera(int index) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile.value = pickedFile.path;
      print("-==-----$imageFile");
      imageFileSt=imageFile.value;

      apiModel.value.items?[index].thumbnailUrl = imageFile.value;
      apiModel.value.items?[index].image = imageFile.value;

      log("========== this is ok=====>${apiModel.value.items?[index].thumbnailUrl.toString()}");
      log(index.toString());
      // imageList.add(imageFile.value!);

    }
  }


  Future fetchData() async {
    apiModel.value = await apiService.getUser();

    log("APIMODEL --------------->${apiModel.value.items?[0].title.toString()}");
  }

}