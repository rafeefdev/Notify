import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

/// Model data untuk sebuah catatan.
///
/// Kelas ini bersifat **immutable**. Artinya, setelah sebuah objek Note dibuat,
/// isinya tidak bisa diubah. Untuk mengubahnya, gunakan metode `copyWith`
/// yang akan membuat objek baru dengan nilai yang diperbarui.
@immutable
class Note {
  /// ID unik untuk setiap catatan, dibuat secara otomatis.
  final String noteID;

  /// Judul catatan.
  final String title;

  /// Isi dari catatan.
  final String content;

  /// Waktu kapan catatan ini dibuat atau terakhir diubah.
  final DateTime timeStamp;

  /// Constructor untuk membuat Note baru.
  ///
  /// [title] dan [content] wajib diisi.
  /// [noteID] bersifat opsional; jika tidak disediakan, ID baru akan dibuat.
  /// Ini berguna saat memuat data dari database yang sudah memiliki ID.
  Note({
    required this.title,
    required this.content,
    String? noteID,
  })  : noteID = noteID ?? const Uuid().v4(),
        timeStamp = DateTime.now();

  /// Membuat salinan dari Note ini dengan beberapa field yang diperbarui.
  Note copyWith({
    String? title,
    String? content,
  }) {
    return Note(
      // Gunakan kembali ID yang ada, jangan buat yang baru.
      noteID: noteID,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }
}
