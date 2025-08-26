import 'dart:math';

import 'package:demonotes_getx/domain/models/note_model.dart';
import 'package:demonotes_getx/domain/repositories/note_repository.dart';

class MockNoteRepository extends NoteRepository {
  Random rnd = Random();
  @override
  Future<List<NoteModel>> filterAsync(NoteFilterQuery query) async {
    List<NoteModel> result = [];
    int n = rnd.nextInt(100);
    for(int i = 0; i < n; i++) {
      String noteText = "asdf";
      if (query.keyword != null) noteText += query.keyword!;
      result.add(NoteModel(id: 'note-$i', text: noteText));
    }
    Future.delayed(Duration(seconds: 3));
    return result;
  }
}