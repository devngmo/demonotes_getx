import 'package:demonotes_getx/app/service_locator.dart';
import 'package:demonotes_getx/common/models/StateCollectionData.dart';
import 'package:demonotes_getx/domain/models/note_model.dart';
import 'package:demonotes_getx/domain/repositories/note_repository.dart';
import 'package:demonotes_getx/widgets/search_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}

class HomeController extends GetxController {
  var activeNotes = FilterableStateCollectionData<NoteModel, NoteFilterQuery>(items: []).obs;
  var archivedNotes = FilterableStateCollectionData<NoteModel, NoteFilterQuery>(items: []).obs;
  var secretNotes = FilterableStateCollectionData<NoteModel, NoteFilterQuery>(items: []).obs;

  List<NoteModel> get filteredNotes {
    if (tabIndex == 0) return activeNotes.value.items;
    else if (tabIndex == 1) return secretNotes.value.items;
    return archivedNotes.value.items;
  }

  bool get isActiveTabLoading {
    if (tabIndex == 0) return activeNotes.value.isProcessing;
    else if (tabIndex == 1) return secretNotes.value.isProcessing;
    return archivedNotes.value.isProcessing;
  }
  var _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;

  SearchViewController svController = SearchViewController();

  String get currentTabSearchKeyword {
    if (tabIndex == 0) {
      if (activeNotes.value.query == null) return "";
      if (activeNotes.value.query!.keyword == null) return "";
      return activeNotes.value.query!.keyword!;
    }
    if (tabIndex == 1) {
      if (secretNotes.value.query == null) return "";
      if (secretNotes.value.query!.keyword == null) return "";
      return secretNotes.value.query!.keyword!;
    }
    if (archivedNotes.value.query == null) return "";
    if (archivedNotes.value.query!.keyword == null) return "";
    return archivedNotes.value.query!.keyword!;
  }
  @override
  void onInit() {
    super.onInit();
    debugPrint("HomeController.onInit");
    filterNotes();
  }

  filterNotes({String? keyword}) {
    debugPrint("HomeController.fetchNotes...");
    if (tabIndex == 0)
      fetchActiveNotes(keyword: keyword);
    else if (tabIndex == 1)
      fetchSecretNotes(keyword: keyword);
    else
      fetchArchivedNotes(keyword: keyword);
  }

  fetchActiveNotes({String? keyword}) {
    NoteFilterQuery query = NoteFilterQuery(keyword: keyword);
    activeNotes.value = FilterableStateCollectionData(items: [], query: query, isProcessing: true);
    serviceLocator.noteRepository.filterAsync(query)
        .then((result) {
          if (activeNotes.value.query == null || activeNotes.value.query!.isEquals(result.query) == false) return;
      debugPrint("  found ${result.notes.length} active notes");
      activeNotes.value = FilterableStateCollectionData(items: result.notes, query: result.query, isProcessing: false);
    });
  }

  fetchSecretNotes({String? keyword}) {
    NoteFilterQuery query = NoteFilterQuery(keyword: keyword);
    secretNotes.value = FilterableStateCollectionData(
        items: [], query: query, isProcessing: true);
    serviceLocator.noteRepository.filterAsync(query)
        .then((result) {
      if (secretNotes.value.query == null || secretNotes.value.query!.isEquals(result.query) == false) return;
      debugPrint("  found ${result.notes.length} secret notes");
      secretNotes.value = FilterableStateCollectionData(
          items: result.notes, query: result.query, isProcessing: false);
    });
  }

  fetchArchivedNotes({String? keyword}) {
    NoteFilterQuery query = NoteFilterQuery(keyword: keyword);
    archivedNotes.value = FilterableStateCollectionData(
        items: [], query: query, isProcessing: true);
    serviceLocator.noteRepository.filterAsync(query)
        .then((result) {
      if (archivedNotes.value.query == null || archivedNotes.value.query!.isEquals(result.query) == false) return;
      debugPrint("  found ${result.notes.length} archived notes");
      archivedNotes.value = FilterableStateCollectionData(
          items: result.notes, query: result.query, isProcessing: false);
    });
  }

  void selectTabAt(int index) {
    _tabIndex.value = index;
    svController.setText(currentTabSearchKeyword);
  }
}