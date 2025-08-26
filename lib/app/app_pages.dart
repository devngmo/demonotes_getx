import 'package:demonotes_getx/app/app_routes.dart';
import 'package:demonotes_getx/controllers/home_controller.dart';
import 'package:demonotes_getx/presentation/home_page.dart';
import 'package:get/get.dart';

final AppPages = [
  GetPage(name: AppRoutes.Home, page: () => HomePage(), binding: HomePageBinding())
];