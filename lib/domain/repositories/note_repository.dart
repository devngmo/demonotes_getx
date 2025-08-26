import 'package:demonotes_getx/domain/models/note_model.dart';

class NoteFilterQuery {
  final String? keyword;
  NoteFilterQuery({this.keyword});
}

abstract class NoteRepository {
  Future<List<NoteModel>> filterAsync(NoteFilterQuery query) async {
    return [];
  }
}