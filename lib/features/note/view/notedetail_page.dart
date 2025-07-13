import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notify/core/extensions/extensions.dart';
import 'package:notify/core/note_model.dart';
import 'package:notify/features/note/viewmodel/note_viewmodel.dart';

class NotedetailPage extends ConsumerStatefulWidget {
  final String selectedNoteID;
  const NotedetailPage({required this.selectedNoteID, super.key});

  @override
  ConsumerState<NotedetailPage> createState() => _NotedetailPageState();
}

class _NotedetailPageState extends ConsumerState<NotedetailPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    // 1. Baca state awal SEKALI di initState.
    final selectedNote = ref.read(noteViewModelProvider).firstWhere(
          (element) => element.noteID == widget.selectedNoteID,
        );

    _titleController = TextEditingController(text: selectedNote.title);
    _contentController = TextEditingController(text: selectedNote.content);

    // 2. Tambahkan listener untuk sinkronisasi real-time.
    _titleController.addListener(_syncStateWithViewModel);
    _contentController.addListener(_syncStateWithViewModel);
  }

  void _syncStateWithViewModel() {
    // 3. Buat objek Note baru dengan data terbaru dari UI.
    final updatedNote = Note(
      noteID: widget.selectedNoteID, // Gunakan ID yang sama
      title: _titleController.text,
      content: _contentController.text,
    );
    // 4. Panggil notifier untuk memperbarui state.
    //    Gunakan ref.read() agar tidak memicu build ulang yang tidak perlu di halaman ini.
    ref.read(noteViewModelProvider.notifier).updateNote(updatedNote);
  }

  @override
  void dispose() {
    // 5. Hapus listener dan dispose controller.
    _titleController.removeListener(_syncStateWithViewModel);
    _contentController.removeListener(_syncStateWithViewModel);
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Widget anak sekarang hanya menerima controller.
              TitleEditor(titleController: _titleController),
              ContentEditor(contentController: _contentController),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleEditor extends StatelessWidget {
  const TitleEditor({super.key, required this.titleController});
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      style: context.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Note Title',
        hintStyle: context.textTheme.titleLarge!.copyWith(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
      // Tidak ada lagi logika `onChanged` di sini.
    );
  }
}

class ContentEditor extends StatelessWidget {
  const ContentEditor({super.key, required this.contentController});
  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: contentController,
      style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w300),
      maxLines: null, // Biarkan textfield mengembang sesuai isi
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'write note here',
        hintStyle: context.textTheme.bodyLarge!.copyWith(
          color: Colors.grey,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
