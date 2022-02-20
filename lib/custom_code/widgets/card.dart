// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom widget code
class Card extends StatefulWidget {
  const Card({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: Color(0xFF262626),
      ),
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Color(0xFF1A1A1A),
          ),
          Align(
            alignment: AlignmentDirectional(-0.06, -0.12),
            child: Image.asset(
              'assets/images/Group_704.png',
              width: 35,
              height: 35,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
