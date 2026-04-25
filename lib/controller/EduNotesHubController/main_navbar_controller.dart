import 'package:get/get.dart';

class MainNavBarController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
