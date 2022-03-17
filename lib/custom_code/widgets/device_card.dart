// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom widget code
class DeviceCard extends StatefulWidget {
  const DeviceCard({
    Key key,
    this.width,
    this.height,
    this.image,
    this.devicename,
    this.deviceholder,
  }) : super(key: key);

  final double width;
  final double height;
  final String image;
  final String devicename;
  final String deviceholder;

  @override
  _DeviceCardState createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  @override
  Widget build(BuildContext context) {
    return // Generated code for this Card Widget...
        Padding(
      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Color(0xFF262626),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(3, 0, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
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
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Mi Band',
                          style: TextStyle(
                            color: Color(0xFFAFAFAF),
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Grandpa',
                          style: TextStyle(
                            color: Color(0xFFAFAFAF),
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
