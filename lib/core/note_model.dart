import 'package:uuid/uuid.dart';

class Note {
  String noteID;
  String title;
  String content;
  DateTime timeStamp;

  Note({required this.noteID, required this.title, required this.content})
    : timeStamp = DateTime.timestamp() {
    noteID = Uuid().v4();
  }

  Note copyWith({String? newID, String? newTitle, String? newContent}) {
    return Note(
      noteID: newID ?? noteID,
      title: newTitle ?? title,
      content: newContent ?? content,
    );
  }
}
