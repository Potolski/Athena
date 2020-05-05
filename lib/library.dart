import 'dart:io';
import 'package:flutter/services.dart';
import 'package:folder_picker/folder_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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

  _addDirectory(Directory folder) async {
    var content = await folder.list()
      .where((f) => f is File && lookupMimeType(f.path).startsWith("audio"))
      .toList();
    this.files[folder.path] = content;
  }

  addFolders(BuildContext context) async {
    final directory = await getExternalStorageDirectory();
    final rdir = directory.path
      .replaceFirst("Android/data/com.example.example/files", "");
    Map<PermissionGroup, PermissionStatus> permissions =
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);

    Navigator.of(context).push<FolderPickerPage>(
        MaterialPageRoute(builder: (BuildContext context) {
          return FolderPickerPage(
            rootDirectory: Directory(rdir),
            action: (BuildContext context, Directory folder) async {
              this.folders.add(folder);
              this._addDirectory(folder);
              Navigator.of(context).pop();
          });
    }));
  }
}
