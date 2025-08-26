import 'package:demonotes_getx/app/service_locator.dart';
import 'package:demonotes_getx/common/models/StateCollectionData.dart';
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
  var filteredNotes = FilterableStateCollectionData<NoteModel, NoteFilterQuery>(items: []).obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint("HomeController.onInit");
    fetchNotes();
  }

  fetchNotes() {
    debugPrint("HomeController.fetchNotes...");
    NoteFilterQuery query = NoteFilterQuery();
    filteredNotes.value = FilterableStateCollectionData(items: [], query: query, isProcessing: true);
    serviceLocator.noteRepository.filterAsync(query)
        .then((result) {
      debugPrint("  found ${result.notes.length} notes");
      filteredNotes.value = FilterableStateCollectionData(items: result.notes, isProcessing: false);
    });
  }

  void filter(String text) {
    debugPrint("HomeController.filter keyword=$text...");
    NoteFilterQuery query = NoteFilterQuery(keyword: text.trim());
    filteredNotes.value = FilterableStateCollectionData(items: [], query: query, isProcessing: true);
    serviceLocator.noteRepository.filterAsync(query)
        .then((result) {
      debugPrint("  found ${result.notes.length} notes for query=${result.query.keyword}");

          if (!filteredNotes.value.query!.isEquals(query)) {
            debugPrint(" SKIP this");
            return;
          }

      filteredNotes.value = FilterableStateCollectionData(items: result.notes, isProcessing: false);
    });
  }
}