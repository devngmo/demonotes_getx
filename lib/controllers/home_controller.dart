import 'package:demonotes_getx/app/service_locator.dart';
import 'package:demonotes_getx/common/models/StateCollectionData.dart';
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
  var filteredNotes = StateCollectionData(items: []).obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint("HomeController.onInit");
    fetchNotes();
  }

  fetchNotes() {
    debugPrint("HomeController.fetchNotes...");
    filteredNotes.value = StateCollectionData(items: [], isProcessing: true);
    serviceLocator.noteRepository.filterAsync(NoteFilterQuery())
        .then((result) {
      debugPrint("  found ${result.length} notes");
      filteredNotes.value = StateCollectionData(items: result, isProcessing: false);
    });
  }

  void filter(String text) {
    debugPrint("HomeController.filter keyword=$text...");
    filteredNotes.value = StateCollectionData(items: [], isProcessing: true);
    serviceLocator.noteRepository.filterAsync(NoteFilterQuery(keyword: text.trim()))
        .then((result) {
      debugPrint("  found ${result.length} notes");
      filteredNotes.value = StateCollectionData(items: result, isProcessing: false);
    });
  }
}