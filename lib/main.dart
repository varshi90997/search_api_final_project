import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_api/pagination/home_page.dart';
import 'package:search_api/routes/routes.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const SearchApi());
}

class SearchApi extends StatelessWidget {
  const SearchApi({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:  HomePage(),
            // initialRoute: Routes.searchScreen,
            // getPages: getPages,
          );
        }
    );
  }
}


