import 'dart:collection';
import 'dart:io';
import 'dart:convert';

class DataService{
  Directory directory=Directory(Directory.current.path+'\\assets\\data');
  late File file;

  /// this method use for initialization......
Future<void> init()async{
bool isDirectlyCreated=await directory.exists();
if(!isDirectlyCreated){
  await directory.create();
}
file=File(directory.path+'\\data.json');
bool isFileCreated=await file.exists();
if(!isFileCreated){
 await file.create();
}
}

/// this method to use for store data
Future<bool> storeData({required String key,required String value})async{
  if(value !is num && value !is String && value !is bool && value !is List && value !is Map && value !is Set && value !is Queue){
    return false;
  }
  String source= await file.readAsString();
  Map<String,dynamic>database;
  if(source.isEmpty){
    database={};
  }else{
    database=jsonDecode(source);
  }
  bool result=false;
  database.addAll({key:value});
  source=jsonEncode(database);
  await file.writeAsString(source).whenComplete(() {result=true;}).catchError((_) {result=false;});
  return result;
}

/// This method to use for read data
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