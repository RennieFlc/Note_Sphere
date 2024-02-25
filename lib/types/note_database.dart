import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'note.dart';

class NoteDatabase extends ChangeNotifier{

  static late Isar isar;

  // Database Initialization
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
        [NoteSchema],
        directory: dir.path,
    );
  }

  // list goes here
  final List<Note> currentNotes = [];


  //Saving note to database here
  Future<void> addNote(String textFromUser) async {

    final newNote = Note()..text = textFromUser;

    //db

    await isar.writeTxn(() => isar.notes.put(newNote));

    //fetch from db
    fetchNotes();
  }

  //Reading from DB goes here
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  //updating in DB here
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if(existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  //Deleting from DB here
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}