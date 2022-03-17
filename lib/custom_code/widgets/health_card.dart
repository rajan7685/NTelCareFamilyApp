// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom widget code
class HealthCard extends StatefulWidget {
  const HealthCard({
    Key key,
    this.width,
    this.height,
    this.image,
  }) : super(key: key);

  final double width;
  final double height;
  final String image;

  @override
  _HealthCardState createState() => _HealthCardState();
}

class _HealthCardState extends State<HealthCard> {
  @override
  Widget build(BuildContext context) {
    return // Generated code for this Card Widget...
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
    );
  }
}
