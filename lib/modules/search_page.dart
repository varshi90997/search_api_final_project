import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_api/modules/image_picker_page/image_picker_page.dart';
import 'package:search_api/modules/search_controller.dart';
import 'package:search_api/modules/search_service.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ApiService apiService = ApiService();

  TextEditingController searchNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  SearchController searchController = Get.put(SearchController());

  String? passForData;
  Timer? debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.w),
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(3.w),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.w)),
                    hintText: "Please enter Name",
                    fillColor: Colors.white54),
                onChanged: (value) async {
                  //------> for a debounce in flutter
                  if (debounce?.isActive ?? false) debounce?.cancel();
                  debounce = Timer(const Duration(milliseconds: 10), () async {

                    passForData = searchNameController.text.toString();
                    searchController.apiModel.value =
                        await apiService.getUser(name: passForData);
                  });
                  /// {{1}} store data in controller services
                },
                controller: searchNameController,
              ),
            ),
            Obx(() => (searchController.apiModel.value.items?.isNotEmpty ??
                    false)
                ? Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: searchController.apiModel.value.items?.length,
                      itemBuilder: (context, index) {
                        log("======= for next page value========> ${searchController.apiModel.value.items?[index].thumbnailUrl.toString().toString()}");

                        /// {{2}} for paass data in second page
                        return GestureDetector(
                          onTap: () {
                            Get.to(ImageShowPage(), arguments: {
                              'index': index,
                              'image': searchController.apiModel.value
                                          .items?[index].thumbnailUrl.toString()
                                           ==
                                      "null"
                                  ? "assets/images/images.png"
                                  : searchController.apiModel.value
                                      .items?[index].thumbnailUrl,
                              'name': searchController
                                  .apiModel.value.items?[index].title
                                  .toString(),
                              'trusted': searchController
                                  .apiModel.value.items?[index].isTrusted,
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(3.w)),
                            child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                minVerticalPadding: 0,
                                /// {{3}} for image
                                leading: searchController.apiModel.value
                                            .items?[index].thumbnailUrl
                                            .toString() ==
                                        "null"
                                    ? Container(
                                        margin: const EdgeInsets.all(8),
                                        height: 6.h,
                                        width: 6.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4.w),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/images.png'))))
                                    : (searchController.apiModel.value.items?[index].image == null
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CachedNetworkImage(
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Container(
                                                  height: 6.h,
                                                  width: 6.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7.w),
                                                      image: DecorationImage(
                                                          image:
                                                              CachedNetworkImageProvider(
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
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(left: 2.w),
                                            height: 6.h,
                                            width: 6.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: FileImage(File(
                                                        searchController
                                                                .apiModel
                                                                .value
                                                                .items?[index]
                                                                .thumbnailUrl
                                                                .toString()
                                                                .toString() ??
                                                            "")),
                                                    fit: BoxFit.fill),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25.w)),
                                          )),

                                ///for name

                                title: Text(
                                    "${searchController.apiModel.value.items?[index].title.toString()}",
                                    style:
                                        const TextStyle(color: Colors.white)),

                                ///for icons

                                trailing: searchController.apiModel.value
                                            .items?[index].isTrusted
                                            .toString() ==
                                        "true"
                                    ? Padding(
                                        padding: EdgeInsets.only(right: 1.w),
                                        child: Image(
                                          image: const AssetImage(
                                              'assets/images/tick-mark.png'),
                                          height: 4.h,
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(right: 2.w),
                                        child: Image(
                                            image: const AssetImage(
                                                'assets/images/checked.png'),
                                            height: 3.h),
                                      )),
                          ),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text("no data found"),
                  )),
          ],
        ),
      ),
    );
  }
}
