import 'package:flutter/material.dart';
import 'package:tafaqquh_note/features/note/notes_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Notify',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
