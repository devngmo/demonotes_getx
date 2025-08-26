import 'package:demonotes_getx/domain/models/note_model.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}

class HomeController extends GetxController {
  List<NoteModel> notes = <NoteModel>[].obs;
}