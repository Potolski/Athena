import 'package:flutter/material.dart';
import 'package:athena/views/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter WebView',
        theme: ThemeData(
          primaryColor: Colors.teal,
          scaffoldBackgroundColor: Colors.grey[850],
          iconTheme: IconThemeData(
            color :  Colors.blue[500], 
          ),
        ),
        home: HomePage());
  }
}
