import 'package:flutter/material.dart';
import 'package:notify/core/extensions.dart';

class NoteGridTile extends StatelessWidget {
  const NoteGridTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Note Title',
                style: context.textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'This is a note content. I save all important info here',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: Colors.grey.shade600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
