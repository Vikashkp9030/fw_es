import 'package:get/get.dart';

import '../../modules/home/views/home_view.dart';

abstract final class AppPages {
  static final pages = <GetPage<void>>[
    GetPage<void>(name: '/', page: HomeView.new),
  ];
}
