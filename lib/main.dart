import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:search_api/modules/search_page.dart';
import 'package:search_api/routes/routes.dart';
import 'package:sizer/sizer.dart';

import 'delet/delet.dart';
import 'delet/pagination.dart';

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
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // home:  Pagination(),
            initialRoute: Routes.searchScreen,
            getPages: getPages,
          );
        }
    );
  }
}


