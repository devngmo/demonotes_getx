import 'package:demonotes_getx/domain/models/note_model.dart';

class NoteFilterQuery {
  final String? keyword;
  final int page;
  final int pageSize;
  NoteFilterQuery({this.keyword, this.pageSize = 20, this.page = 1});

  bool isEquals(NoteFilterQuery query) {
    if (keyword != query.keyword) return false;
    if (page != query.page) return false;
    if (pageSize != query.pageSize) return false;
    return true;
  }
}

class NoteFilterPageResult {
  final NoteFilterQuery query;
  final List<NoteModel> notes;
  NoteFilterPageResult({required this.query, required this.notes});
}

abstract class NoteRepository {
  Future<NoteFilterPageResult> filterAsync(NoteFilterQuery query) async {
    return NoteFilterPageResult(query: query, notes: []);
  }
}