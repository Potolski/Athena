import 'dart:io';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class Library {
  static final Library _instance = Library._internal();
  List<Directory> folders;
  Map<String, List<File>> files;
  factory Library() {
    return _instance;
  }

  Library._internal() {
    this.folders = [];
  }

  addFolder(Directory folder) async {
    var content = await folder.list()
      .where((f) => f is File && lookupMimeType(f.path).startsWith("audio"))
      .toList();
    this.files[folder.path] = content;
  }
}
