import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwitchChatWidget extends StatefulWidget {
  const SwitchChatWidget({Key key}) : super(key: key);

  @override
  _SwitchChatWidgetState createState() => _SwitchChatWidgetState();
}

class _SwitchChatWidgetState extends State<SwitchChatWidget> {
  bool switchListTileValue;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: switchListTileValue ??= false,
      onChanged: (newValue) => setState(() => switchListTileValue = newValue),
      title: Text(
        'Enable Chat',
        style: FlutterFlowTheme.of(context).title3.override(
              fontFamily: 'Poppins',
              color: Color(0xFFE5E5E5),
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
      ),
      tileColor: Color(0xFFF5F5F5),
      dense: false,
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }
}
