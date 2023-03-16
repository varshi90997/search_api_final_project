import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:search_api/modules/search_page.dart';

class Routes {
  static String searchScreen = '/searchScreen';
}


final getPages = [
  GetPage(
    name: Routes.searchScreen,
    page: () => SearchPage(),
  ),
];
