import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_sphere/types/note_database.dart';
import 'package:provider/provider.dart';

 class NotePage extends StatefulWidget {

 const NotePage({super.key});

 @override
 State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage>{

   final textController = TextEditingController();

   //creating note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
          ),
         actions: [
           MaterialButton(
               onPressed: () {

                 context.read<NoteDatabase>().addNote(textController.text);

                 Navigator.pop(context);

               },
             child: const Text("create"),
             )
          ],
        ),
     );
  }

  //reading notes here














  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),




    );
  }
}
