class Note {
  String noteID;
  String title;
  String content;
  DateTime timeStamp;

  Note({required this.noteID, required this.title, required this.content})
    : timeStamp = DateTime.timestamp();
}
