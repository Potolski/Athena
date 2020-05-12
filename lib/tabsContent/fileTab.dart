import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:athena/components/audioBtn.dart';
import '../library.dart';

typedef void OnError(Exception exception);

class FileTab extends StatefulWidget {
  @override
  _FileTab createState() => new _FileTab();
}

class _FileTab extends State<FileTab> {

  String localFilePath;

  Widget build(BuildContext ctx) {
    return Center(
        child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AudioBtn(
                      onPressed: () => Library().addFolders(ctx),
                      iconData: Icons.folder)
                ])));
  }
}
