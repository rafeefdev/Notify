import 'package:flutter/material.dart';
import 'package:notify/core/extensions/theme_extensions.dart';
import 'package:notify/core/note_model.dart';

class NoteGridTile extends StatelessWidget {
  final Note note;
  const NoteGridTile({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: context.textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Expanded(
              child: Text(
                note.content,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: Colors.grey.shade600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
