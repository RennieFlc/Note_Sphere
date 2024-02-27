import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(title: Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          final note = currentNotes[index];


          return ListTile(
            title: Text(note.text),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //edit button goes here!!

                IconButton(
                    onPressed: () => updateNote(note),
                    icon: const Icon(Icons.edit),
                ),

                //delete button goes here!!

                IconButton(
                    onPressed: () => deleteNote(note.id),
                    icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
