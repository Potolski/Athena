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
        backgroundColor: Colors.black,  
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.audiotrack, color: Colors.blue[600])),
              Tab(icon: Icon(Icons.library_books, color: Colors.blue[600])),
            ],
          ),
          title: Text('Athena', style: TextStyle(
              color: Colors.blue[600],
          )),
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
