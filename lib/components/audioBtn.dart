import 'package:flutter/material.dart';

class AudioBtn extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;

  AudioBtn({@required this.onPressed, @required this.iconData});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 60.0,
        child: IconButton(
          icon: Icon(iconData),
          onPressed: () {
            onPressed();
          },
        ));
  }
}
