import 'dart:io';
import 'package:flutter/services.dart';
import 'package:folder_picker/folder_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mime/mime.dart'

class Library {
  static final Library _instance = Library._internal();
  List<Directory> folders;

  factory Library() {
    return _instance;
  }

  Library._internal() {
    this.folders = [];
  }

  _addDirectory(Directory folder) {

    folder.list(recursive: true)
      .where((x) => x is File && lookupMimeType(x.path).startsWith("audio"))


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
              print(folder.toString());
              Navigator.of(context).pop();
          });
    }));
  }
}
