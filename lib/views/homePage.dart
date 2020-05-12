import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:athena/tabsContent/audioTab.dart';
import 'package:athena/tabsContent/fileTab.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.audiotrack)),
              Tab(icon: Icon(Icons.library_books)),
            ],
          ),
          title: Text('Athena'),
        ),
        body: TabBarView(
          children: [
            AudioTab(),
            FileTab(),
          ],
        ),
      ),
    );
  }
}
