import 'dart:io';

/// this service for input and operator

void write<T>(T object){
  stdout.write(object);
}

void writeln<T>(T object){
  stdout.writeln(object);
}

String read(){
  String result=stdin.readLineSync() ?? '';
  return result;
}