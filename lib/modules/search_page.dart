import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_api/modules/search_controller.dart';
import 'package:search_api/modules/search_model.dart';
import 'package:search_api/modules/search_service.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchController searchController = SearchController();

  ApiService apiService = ApiService();

  int test = 0;

  TextEditingController searchNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<ApiModel> forFetch() async
  {
    return searchController.apiModel.value =
        await apiService.getUser(searchNameController.text.toString());
  }

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
                  searchController.apiModel.value = await apiService
                      .getUser(searchNameController.text.toString());

                  /// {{1}} store data in controller services
                },
                controller: searchNameController,
              ),
            ),
            Obx(() => (searchController.apiModel.value.items?.isNotEmpty ??
                    false)
                ? Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.snackbar(
                          "note:",
                          "please don't clicked",
                          colorText: Colors.white,
                          duration: const Duration(seconds: 1),
                          backgroundColor: Colors.lightBlue,
                          icon: const Icon(Icons.add_alert),
                        );
                      },
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount:
                            searchController.apiModel.value.items?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(3.w)),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              minVerticalPadding: 0,
                              leading: searchController.apiModel.value
                                          .items?[index].thumbnailUrl
                                          .toString() ==
                                      "null"
                                  ? Container(
                                margin: const EdgeInsets.all(8),
                                height: 6.h,
                                      width: 6.h,
                                      decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(4.w),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/images.png'))))
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CachedNetworkImage(
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            height: 6.h,
                                            width: 6.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7.w),
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
                                    ),
                              title: Text(
                                  "${searchController.apiModel.value.items?[index].title.toString()}",
                                  style:  const TextStyle(color: Colors.white)),
                              trailing: searchController.apiModel.value
                                          .items?[index].isTrusted
                                          .toString() ==
                                      "true"
                                  ?  Image(image: const AssetImage('assets/images/tick-mark.png'),height: 4.h,)
                                  :  Image(image: const AssetImage('assets/images/checked.png'),height: 3.h)

                            ),
                          );
                        },
                      ),
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
