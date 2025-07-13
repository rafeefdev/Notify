import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tafaqquh_note/core/extensions/theme_extensions.dart';
import 'package:tafaqquh_note/core/get_initials.dart';
import 'package:tafaqquh_note/core/note_model.dart';
import 'package:tafaqquh_note/features/auth/user_model.dart';
import 'package:tafaqquh_note/features/note/view/notedetail_page.dart';
import 'package:tafaqquh_note/features/note/view/notegridtile_component.dart';
import 'package:tafaqquh_note/features/note/viewmodel/note_viewmodel.dart';

class HomePage extends ConsumerWidget {
  final User? currentUser = User(name: 'jaka', email: 'jaka@gmail.com');
  bool get _isAnonymous => currentUser == null;

  HomePage({super.key});

  void _showAddNoteSheet(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true, // Penting untuk keyboard
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _TitleEditor(titleController: titleController),
              _ContentEditor(contentController: contentController),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: _SubmitButton(
                  titleController: titleController,
                  contentController: contentController,
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: CustomScrollView(
          slivers: [
            _BuildCustomAppBar(
              currentUser: currentUser,
              isAnonymous: _isAnonymous,
              context: context,
            ),
            SliverToBoxAdapter(child: SizedBox(height: 24)),
            _BuildNotes(context: context, ref: ref),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddNoteSheet(context, ref),
        label: const Text('Add Note'),
        icon: Icon(Icons.add_circle_outline_rounded),
      ),
    );
  }
}

class _BuildCustomAppBar extends StatelessWidget {
  const _BuildCustomAppBar({
    super.key,
    required this.currentUser,
    required bool isAnonymous,
    required this.context,
  }) : _isAnonymous = isAnonymous;

  final User? currentUser;
  final bool _isAnonymous;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello ${currentUser!.name} !',
                style: context.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Save important info here !',
                style: context.textTheme.bodyLarge!,
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                child: _isAnonymous
                                    ? Icon(Icons.person_2_rounded)
                                    : Text(getInitials(currentUser!.name)),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _isAnonymous
                                    ? 'Anonymous User'
                                    : currentUser!.name,
                                style: context.textTheme.titleSmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 48),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FilledButton(
                              onPressed: () {},
                              child: const Text('Sign-in with Google'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: CircleAvatar(
              child: _isAnonymous
                  ? Icon(Icons.person_2_rounded)
                  : Text(getInitials(currentUser!.name)),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildNotes extends StatelessWidget {
  const _BuildNotes({super.key, required this.context, required this.ref});

  final BuildContext context;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(noteViewModelProvider);

    if (notes.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.note_alt_outlined, size: 80, color: Colors.grey),
              const SizedBox(height: 12),
              Text('No notes yet.', style: context.textTheme.titleLarge),
              SizedBox(height: 8),
              Text(
                "Tap '+' to add a new note.",
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    }

    return SliverGrid.count(
      crossAxisCount: 2,
      childAspectRatio: 9.5 / 8,
      crossAxisSpacing: 8,
      mainAxisSpacing: 12,
      children: notes.map((note) {
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NotedetailPage(selectedNoteID: note.noteID);
              },
            ),
          ),
          child: NoteGridTile(note: note),
        );
      }).toList(),
    );
  }
}

class _SubmitButton extends ConsumerWidget {
  const _SubmitButton({
    super.key,
    required this.titleController,
    required this.contentController,
  });

  final TextEditingController titleController;
  final TextEditingController contentController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton(
      onPressed: () {
        if (titleController.text.isNotEmpty ||
            contentController.text.isNotEmpty) {
          ref
              .read(noteViewModelProvider.notifier)
              .addNote(
                title: titleController.text,
                content: contentController.text,
              );
          Navigator.pop(context); // Tutup bottom sheet
        }
      },
      child: Text('Save Note'),
    );
  }
}

class _ContentEditor extends StatelessWidget {
  const _ContentEditor({super.key, required this.contentController});

  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: contentController,
      style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w300),
      maxLines: 5,
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

class _TitleEditor extends StatelessWidget {
  const _TitleEditor({super.key, required this.titleController});

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
    );
  }
}
