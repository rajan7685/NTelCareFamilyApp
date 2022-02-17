// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom widget code
class CardDetails extends StatefulWidget {
  const CardDetails({Key key, this.width, this.height}) : super(key: key);

  final double width;
  final double height;

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  @override
  Widget build(BuildContext context) {
    String text;
    return // Generated code for this Card Widget...
        Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Color(0xFF1A1A1A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      text = 'Text not available';
                    });
                  },
                ),
                Image.asset(
                  'assets/images/Line_49.png',
                  width: 2,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                ),
                Image.asset(
                  'assets/images/Line_49.png',
                  width: 2,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                ),
                Image.asset(
                  'assets/images/Line_49.png',
                  width: 2,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                ),
                Image.asset(
                  'assets/images/Line_49.png',
                  width: 2,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                ),
                Image.asset(
                  'assets/images/Line_49.png',
                  width: 2,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text('hi'),
          ),
        ),
      ],
    );
  }
}
