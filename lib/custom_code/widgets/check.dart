// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom widget code
class Check extends StatefulWidget {
  const Check({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  Color color = Colors.yellow;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 300,
          height: 300,
          color:
              color, //value of color which we will change by pressing buttons
        ),

        /* Below Row of Button when pressed will fire up 
                the setState and the state of our default color variable will 
                change according to Button which is pressed
             */
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.red,
              child: Text("Red"),
              onPressed: () {
                setState(() {
                  color = Colors.red;
                });
              },
            ),
            RaisedButton(
              color: Colors.green,
              child: Text("Green"),
              onPressed: () {
                setState(() {
                  color = Colors.green;
                });
              },
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text("Blue"),
              onPressed: () {
                setState(() {
                  color = Colors.blue;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
