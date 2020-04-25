import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'library.dart';


typedef void OnError(Exception exception);

void main() {
  runApp(new MaterialApp(home: new ExampleApp()));
}

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => new _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;  

  @override
  void initState(){
    super.initState();
    initPlayer();
  }
  
  void initPlayer(){
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
      _duration = d;
    });

    advancedPlayer.positionHandler = (p) => setState(() {
    _position = p;
    });
  }

  String localFilePath;

  Widget _tab(List<Widget> children) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: children
              .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
              .toList(),
        ),
      ),
    );
  }

  Widget _btn(String txt, VoidCallback onPressed) {
    return ButtonTheme(
        minWidth: 48.0,
        child: RaisedButton(child: Text(txt), onPressed: onPressed));
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
          });});
  }

  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }
  
  Widget localAsset(BuildContext ctx) {
    return _tab([
      Text('Play Local Asset:'),
      _btn('Play', () => audioCache.play('audio.mp3')),
      _btn('Pause',() => advancedPlayer.pause()),
      _btn('Stop', () => advancedPlayer.stop()),
      _btn('addFolder', () => Library().addFolders(ctx)),
      slider()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Mp3 Player'),
            ],
          ),
          title: Text('Athena'),
        ),
        body: TabBarView(
          children: [localAsset(context)],
        ),
      ),
    );
  }
}
