import 'package:flutter/material.dart';
import 'package:note_sphere/pages/note_page.dart';
import 'package:note_sphere/types/note_database.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();


  runApp(
      ChangeNotifierProvider(
          create: (context) => NoteDatabase(),
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotePage(),
    );
  }
}