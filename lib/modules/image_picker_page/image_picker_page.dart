// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_api/modules/image_picker_page/class_model.dart';
import 'package:search_api/modules/search_controller.dart';
import 'package:search_api/modules/search_model.dart';
import 'package:search_api/modules/search_page.dart';
import 'package:sizer/sizer.dart';

class ImageShowPage extends StatefulWidget {
  ImageShowPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageShowPage> createState() => _ImageShowPageState();
}

class _ImageShowPageState extends State<ImageShowPage> {
  SearchController searchController = Get.put(SearchController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // searchController.imageFile.value = File("");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.imageFile.value = "";
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final index = arguments['index'];
    final image = arguments['image'];
    final name = arguments['name'];
    final trusted = arguments['trusted'];
    log("======== image =============>${searchController.imageFile.value}");

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                // Navigator.pop(context);
                // Get.back();
                // Navigator.popUntil(context, ModalRoute.withName('/searchScreen'));
                Navigator.popAndPushNamed(context, '/searchScreen');
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: Column(children: [
            SizedBox(
              height: 20.h,
            ),

            /// for image
            image == "assets/images/images.png"
                ? Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ///----->main image
                      Obx(() => searchController.imageFile.value.isNotEmpty
                          ? Container(
                              height: 16.h,
                              width: 16.h,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(File(
                                          searchController.imageFile.value)),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(25.w)),
                            )
                          : Container(
                              height: 16.h,
                              width: 16.h,
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(25.w)),
                            )),

                      ///----->icon image
                      Obx(
                        () => searchController.imageFile.isEmpty
                            ? GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.w)),
                                        child: Container(
                                          height: 20.h,
                                          width: 5.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white54,
                                              borderRadius:
                                                  BorderRadius.circular(5.w)),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Spacer(),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.black54),
                                                    onPressed: () {
                                                      searchController
                                                          .pickImageFromGallery(
                                                              index ?? 0);
                                                      Get.back();
                                                    },
                                                    child:
                                                        const Text("Gallery")),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.black54),
                                                    onPressed: () {
                                                      searchController
                                                          .pickImageFromCamera(
                                                              index ?? 0);
                                                      Get.back();
                                                    },
                                                    child:
                                                        const Text("camera")),
                                                const Spacer(),
                                              ]),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 2.w, bottom: 2.w),
                                    child:
                                        searchController.imageFile.value.isEmpty
                                            ? const Icon(
                                                Icons.camera,
                                                color: Colors.black,
                                              )
                                            : const Text("")))
                            : const SizedBox(),
                      )
                    ],
                  )
                : (image.contains(RegExp('/data/user')) //"/data/user"
                    ? Container(
                        height: 16.h,
                        width: 16.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(File(searchController.apiModel
                                        .value.items?[index].thumbnailUrl
                                        .toString() ??
                                    "")),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(25.w)),
                      )
                    : CachedNetworkImage(
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 16.h,
                            width: 16.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.w),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      "${searchController.apiModel.value.items?[index].thumbnailUrl}",
                                    ),
                                    fit: BoxFit.cover)),
                          );
                        },
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        imageUrl:
                            "${searchController.apiModel.value.items?[index].thumbnailUrl}",
                      )),

            /// for name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("   ${name}"),
                SizedBox(
                  width: 1.h,
                ),
                trusted ?? false
                    ? Image(
                        image: const AssetImage('assets/images/tick-mark.png'),
                        height: 4.h,
                      )
                    : Image(
                        image: const AssetImage('assets/images/checked.png'),
                        height: 3.h)
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
