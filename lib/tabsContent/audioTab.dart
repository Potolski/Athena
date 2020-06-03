import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:athena/components/audioBtn.dart';
import 'package:folder_picker/folder_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../library.dart';
import 'package:file_picker/file_picker.dart';


typedef void OnError(Exception exception);

class AudioTab extends StatefulWidget {
  @override
  _AudioTab createState() => new _AudioTab();
}

class _AudioTab extends State<AudioTab> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.onDurationChanged.listen((d) => setState(() {
          _duration = d;
        }));

    advancedPlayer.onAudioPositionChanged.listen((p) => setState(() {
          _position = p;
        }));
  }
  void _selectFolders(BuildContext ctx) async {
    var lib = Library();
    final directory = await getExternalStorageDirectory();
    final rdir = directory.path
      .replaceFirst("Android/data/com.example.example/files", "");
    Map<PermissionGroup, PermissionStatus> permissions =
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    var nav = Navigator.of(ctx);

    nav.push<FolderPickerPage>(
        MaterialPageRoute(builder: (BuildContext context) {
            var page = FolderPickerPage(
            rootDirectory: Directory(rdir),
            action: (BuildContext context, Directory folder) async {
              await lib.addFolder(folder);
              });
            if (page == null)
              print("aaah");
            else print("wtf man");

            return page;
    }));
  }
  void _openFile() {
    Future<File> fileResult =  FilePicker.getFile();
    fileResult
      ..catchError((e) => print(e))
      ..then((value) => this.localFilePath = value.toString());
  }


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
                      onPressed: () async => _selectFolders(ctx),
                      iconData: Icons.folder_open),
                  AudioBtn(
                      onPressed: () async => _openFile(),
                      iconData: Icons.open_in_new),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AudioBtn(
                            onPressed: () => audioCache.play(this.localFilePath),
                            iconData: Icons.play_arrow),
                        AudioBtn(
                            onPressed: () => advancedPlayer.pause(),
                            iconData: Icons.pause),
                        AudioBtn(
                            onPressed: () => advancedPlayer.stop(),
                            iconData: Icons.stop)
                      ]),
                      Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          AudioBtn(
                          onPressed: () =>  advancedPlayer.setPlaybackRate(playbackRate: 2.0),
                          iconData: Icons.exposure_plus_2)
                    ]),
                  slider()
                ])));
  }

  Widget slider() {
    return Slider(
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });
        });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }
}
