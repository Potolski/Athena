import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:athena/components/audioBtn.dart';
import '../library.dart';

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
                      iconData: Icons.folder),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AudioBtn(
                            onPressed: () => audioCache.play('audio.mp3'),
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
