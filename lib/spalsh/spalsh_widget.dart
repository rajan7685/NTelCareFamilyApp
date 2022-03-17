import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../login/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class SpalshWidget extends StatefulWidget {
  const SpalshWidget({Key key}) : super(key: key);

  @override
  _SpalshWidgetState createState() => _SpalshWidgetState();
}

class _SpalshWidgetState extends State<SpalshWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 1000));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginWidget(),
                ),
              );
            },
            child: Image.asset(
              'assets/images/splash__1.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
