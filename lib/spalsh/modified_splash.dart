import 'package:n_tel_care_family_app/core/shared_preferences_service.dart';
import 'package:n_tel_care_family_app/main.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../landing/landing.dart';
import '../login/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifiedSplashWidget extends StatefulWidget {
  const ModifiedSplashWidget({Key key}) : super(key: key);

  @override
  _ModifiedSplashWidgetState createState() => _ModifiedSplashWidgetState();
}

class _ModifiedSplashWidgetState extends State<ModifiedSplashWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    print("object");
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 3000));
      print(" cccc ");
      print(
          " ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)} ");
      print(
          " ${SharedPreferenceService.loadBool(key: AccountsKeys.Executive)} ");
      print(
          " ${SharedPreferenceService.loadBool(key: AccountsKeys.ChatPermission)} ");
      print(
          " ${SharedPreferenceService.loadBool(key: AccountsKeys.LivePermission)} ");
      print(
          " ${SharedPreferenceService.loadBool(key: AccountsKeys.VideoPermission)} ");
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SharedPreferenceService.loadString(
                          key: AccountsKeys.AccessTokenKey) ==
                      null ||
                  SharedPreferenceService.loadString(
                          key: AccountsKeys.AccessTokenKey)
                      .isEmpty
              ? LoginWidget()
              : NavBarPage(initialPage: 'Landing'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/splash.png',
              height: double.infinity,
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
    );
  }
}
