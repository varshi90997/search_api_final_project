import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';
import 'package:search_api/modules/search_controller.dart';
import 'package:search_api/modules/search_service.dart';
import 'package:sizer/sizer.dart';

class Pagination extends StatefulWidget {
  Pagination({Key? key}) : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int get count => list.length;

  List list = [];
  List list1 = [];
  List imagesList = [];
  int counted=1;
  void initState() {
    super.initState();
    forFetch();
  }

  SearchController searchController = Get.put(SearchController());
  ApiService apiService=Get.put(ApiService());

  forFetch() async
  {
      searchController.paginationModel.value = await apiService.getPagination("").whenComplete(() => forFetchSec());

    setState(() {
      
    });
    Obx(() => Text("data"));
  }
  forFetchSec()
  {
    if(searchController.paginationModel.value.results!=null)
      {
        for(int i=0;i<10;i++)
        {
          list.add(searchController.paginationModel.value.results?[i].gender?.toString());
          list1.add(searchController.paginationModel.value.results?[i].name?.title?.toString());
          imagesList.add(searchController.paginationModel.value.results?[i].picture?.thumbnail.toString());
        }
      }
    setState(() {

    });
  }

  void load()  {
    print("load");

    setState(() {

      counted=counted+1;
      apiService.getPagination(counted.toString()).whenComplete(() async {

        searchController.paginationModel.value = await apiService.getPagination("");
      }).whenComplete(() {

      for(int i=0;i<10;i++)
      {
        list.add(searchController.paginationModel.value.results?[i].gender?.toString());
        list1.add(searchController.paginationModel.value.results?[i].name?.title?.toString());
        imagesList.add(searchController.paginationModel.value.results?[i].picture?.thumbnail.toString());

        setState(() {
          print("list ==========================> ${list1}",);

        });
      }

      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Expanded(
               child: RefreshIndicator(
                onRefresh: _refresh,
                child: LoadMore(
                  isFinish: count >= 50,
                  onLoadMore: _loadMore,
                  whenEmptyLoad: false,
                  delegate: const DefaultLoadMoreDelegate(),
                  textBuilder: DefaultLoadMoreTextBuilder.english,
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 80.0,
                          width: 40,
                          alignment: Alignment.center,
                          child:  ListTile(
                            leading: Image(image: NetworkImage(imagesList[index])),
                            title: Text(list[index]),
                            trailing: Text(list1[index]),
                          ),
                          // child: Text("${list1[index].toString()}")
                      );
                    },
                    // itemCount: searchController.paginationModel.value.results?[index].gender?.length,
                  ),
                )),
             ),
          ]),
    );
  }
  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(const Duration(seconds: 0, milliseconds: 6000));
    load();
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    list.clear();

    setState(() {
      forFetch();
    });

  }
}
