
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_api/pagination/Utils/strings.dart';
import 'package:search_api/pagination/user_controller.dart';
import 'package:search_api/routes/routes.dart';
import 'package:sizer/sizer.dart';

import 'Utils/colors.dart';


class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Obx(()=>
          Column(
            children: [
              Obx(
                    () => Expanded(
                  child: _userController.isLoading.value
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : ListView.separated(
                    controller: _userController.scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      var data =_userController.userList[index];//-------->loop through data enter in this list
                      return ListTile(
                        title: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.w),color: Colors.white,),
                          margin: EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.w),
                          height: 10.h,
                          width: 100.w,
                          child: Row(
                            children: [
                              Container(
                                height: 10.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.w),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          "${data.picture!.thumbnail}",
                                        ),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                                width: 46.w,
                                child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 1.w),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("${data.name!.first}" + "\t${data.name!.last}",
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.sp),),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text("${data.email}",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 9.sp,color:  ColorConstants.textGreyColor),),
                                      RichText(text: TextSpan(
                                          children: [
                                            TextSpan(text: "${StringConstants.homeCountry} | ",style: TextStyle(
                                                fontSize: 10.sp,fontWeight: FontWeight.bold,color: ColorConstants.blackColor
                                            )),
                                            TextSpan(text:data.location!.country,style:TextStyle(fontSize: 9.sp,color: ColorConstants.textGreyColor))
                                          ]
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height:3.h,
                                    width: 17.w,
                                    child: Text(_userController.timeAgo(DateTime.parse(data.registered.date)).toString(),
                                      style: TextStyle(color: Colors.black,fontSize: 8.sp,),
                                    ),
                                  ),
                                  Padding(
                                    padding:EdgeInsets.only(bottom: 1.h),
                                    child: SizedBox(
                                      height:2.h,
                                      width:4.w,
                                      child: Icon(Icons.arrow_forward_ios_rounded,
                                          size: 2.h),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 3.h,
                        child: Divider(
                          color: ColorConstants.greyColor,
                          height: 1.h,
                          thickness: 0.4.h,
                        ),
                      );
                    },
                    itemCount: _userController.userList.length,
                  ),
                ),
              ),
              _userController.isPaginationLoading.value?const Center(child: CircularProgressIndicator(),):const SizedBox()
            ],
          ),
      ),
    );
  }


}
