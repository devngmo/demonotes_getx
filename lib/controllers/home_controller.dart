import 'package:demonotes_getx/app/service_locator.dart';
import 'package:demonotes_getx/domain/models/note_model.dart';
import 'package:demonotes_getx/domain/repositories/note_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}

class HomeController extends GetxController {
  List<NoteModel> notes = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint("HomeController.onInit");
    fetchNotes();
  }

  fetchNotes() {
    debugPrint("HomeController.fetchNotes...");
    notes.clear();
    serviceLocator.noteRepository.filterAsync(NoteFilterQuery())
        .then((result) {
      debugPrint("  found ${result.length} notes");
      notes.assignAll(result);
    });
  }

  void filter(String text) {
    debugPrint("HomeController.filter...");
    notes.clear();
    serviceLocator.noteRepository.filterAsync(NoteFilterQuery(keyword: text.trim()))
        .then((result) {
      debugPrint("  found ${result.length} notes");
      notes.assignAll(result);
    });
  }
}