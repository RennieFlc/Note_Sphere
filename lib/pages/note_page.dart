import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sphere/components/drawer.dart';
import 'package:note_sphere/components/note_tile.dart';
import 'package:note_sphere/types/note_database.dart';
import 'package:provider/provider.dart';

import '../types/note.dart';

 class NotePage extends StatefulWidget {

 const NotePage({super.key});

 @override
 State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();


    //fetching existing notes

    readNotes();
  }

  //creating note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                onPressed: () {

                  context.read<NoteDatabase>().addNote(textController.text);

                  textController.clear();

                  Navigator.pop(context);
                },
                child: const Text("create"),
              )
            ],
          ),
    );
  }

  //reading notes here
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  //updating here
  void updateNote(Note note) {

    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text("Update Note"),
          content: TextField(controller: textController),
          actions: [
            //update button
            MaterialButton(
              onPressed: () {
              // now update in DB
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);

              textController.clear();
              
              
              Navigator.pop(context);

              },
              child: const Text("Update"),
            )
          ],
        ),
    );
  }


  // deleting here
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADING HERE!!!
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // LIST OF NOTES HERE!!!!!
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];


                return NoteTile(
                  text: note.text,
                  onEditPressed: () => updateNote(note),
                  onDeletePressed: () => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
