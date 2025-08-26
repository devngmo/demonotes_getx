import 'package:demonotes_getx/app/repositories/mock_note_repository.dart';
import 'package:demonotes_getx/domain/repositories/note_repository.dart';

class ServiceLocator {
  late final NoteRepository noteRepository = MockNoteRepository();
}

final serviceLocator = ServiceLocator();