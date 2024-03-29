

import 'package:flutter/material.dart';
import 'package:note_sphere/pages/note_page.dart';
import 'package:note_sphere/theme/theme_provider.dart';
import 'package:note_sphere/types/note_database.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();


  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => NoteDatabase()),

        ChangeNotifierProvider(create: (context) => ThemeProvider())
        ],
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}