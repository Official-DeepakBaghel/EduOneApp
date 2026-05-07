import 'package:eduone/model/LocalDB/local_db.dart';
import 'package:get/get.dart';

class Degree2DreamNavigationController extends GetxController {
  var currentIndex = 0.obs;
  var userRole = 'student'.obs; // 'student' or 'mentor'

  @override
  void onInit() {
    super.onInit();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final savedRole = await LocalDB.getRole();
    if (savedRole != null) {
      userRole.value = savedRole;
    }
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void toggleRole() async {
    userRole.value = userRole.value == 'student' ? 'teacher' : 'student';
    await LocalDB.saveRole(userRole.value);
    currentIndex.value = 0; // Reset index when switching roles
  }
}
