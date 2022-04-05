import 'package:flutter/material.dart';

class CustomMessage extends StatelessWidget {
  CustomMessage({this.title, this.content, this.onpressed});
  final String title;
  final String content;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onpressed,
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
