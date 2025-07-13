import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/note_model.dart';

part 'note_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class NoteViewModel extends _$NoteViewModel {
  @override
  List<Note> build() {
    // Mengembalikan list kosong sebagai state awal
    return [];
  }

  /// Menambahkan catatan baru ke dalam state
  void addNote({required String title, required String content}) {
    final newNote = Note(title: title, content: content);
    // Membuat list baru dengan menambahkan note baru di awal
    state = [newNote, ...state];
  }

  /// Memperbarui catatan yang sudah ada
  void updateNote(Note updatedNote) {
    state = [
      for (final note in state)
        if (note.noteID == updatedNote.noteID) updatedNote else note,
    ];
  }

  /// Menghapus catatan berdasarkan ID
  void deleteNote(String noteId) {
    state = state.where((note) => note.noteID != noteId).toList();
  }
}
