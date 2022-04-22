import 'dart:convert';
import 'dart:io';

import 'package:note_app_21_april/models/note_model.dart';
import 'package:note_app_21_april/services/io_service.dart';

class FileService {
  Directory directory = Directory(Directory.current.path + '\\assets\\files');

  get file => null;

  /// check created or not
  Future<void> init() async {
    bool isDirectoryCreated = await directory.exists();
    if (!isDirectoryCreated) {
      await directory.create();
    }
  }

  /// cerate file
  Future<String> createFile(String title) async {
    File file = File(directory.path + '\\$title.note');
    bool isFileCreated = await file.exists();
    if (isFileCreated) {
      throw Exception("This file already created please try new file");
    }
    await file.create();
    return file.path;
  }


  /// write to file
  Future<String> writeFile(Note note, String path) async {
    File file = File(path);
    // cryptographic code => encode
    await file.writeAsString(jsonEncode(note.toJson()));
    await file.setLastModified(DateTime.parse(note.time));
    return file.path;
  }

  /// read file
  Future<Note> readFile(String title) async {
    File file = File(directory.path + '\\$title.note');
    bool isFileCreated = await file.exists();
    if (!isFileCreated) {
      throw Exception("File not found");
    }

    String result = await file.readAsString();
    Note note = Note.fromJson(jsonDecode(result));
    return note;
  }

  /// update file
  Future<String> updateFile(String title) async {
    String path = directory.path + '\\$title.note';
    Note note = await readFile(title);
    writeln("O'zgartirmoqchi bo'lgan file note:");
    writeln(note);
    writeln("Yangilanishni kiriting:");
    String content = '';
    String exit = '';
    while (exit != "save") {
      exit = read();
      if (exit == 'save') break;

      content += (exit + '\n');
    }

    note.content=content;
    note.time=DateTime.now().toString();

    return await writeFile(note, path);
  }

  /// delete on file
  Future<bool> deleteData({required String key})async{
    // filedan oldingi ma'lumotlarni oladi
    String source=await file.readAsString();
    // bo'shlikka tekshiradi
    if(source.isEmpty){
      return false;
    }
    Map<String,dynamic> database;
    // String => Map
    database = jsonDecode(source);
    // o'chirishi kerak bo'lgan ma'lumotni o'chirdi
    database.remove(key);
    // Map=> String
    source=jsonEncode(database);

    // Filega yangi o'zgarishni saqlaydi
    await file.writeAsString(source).catchError((_){/* error massage */});
    return true;
  }
}
