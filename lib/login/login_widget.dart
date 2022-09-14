import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:n_tel_care_family_app/backend/ApiService.dart';
import 'package:n_tel_care_family_app/components/custom_toast.dart';
import 'package:n_tel_care_family_app/forgotPasword/forget_password.dart';
import 'package:n_tel_care_family_app/model/loginmodel.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController textController1;
  TextEditingController textController2;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _checkNetworkConnectivity() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    print(connectivityResult.name);
    print(connectivityResult.name);
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
    } else {
      Toast.showToast(
        context,
        type: ToastType.Error,
        message: 'You are not connected to internet.',
      );
    }
  }

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility = false;
    _checkNetworkConnectivity();
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
              'assets/images/login.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0x3443504E), Color(0x4C00B89F)],
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, -1),
                  end: AlignmentDirectional(0, 1),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 75),
                  child: Image.asset(
                    'assets/images/Group 598.png',
                    width: 300,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: TextFormField(
                            controller: textController1,
                            obscureText: false,
                            validator: (value) => textController1.text,
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                              hintText: 'Enter Mobile Number',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF292929),
                                      fontSize: 16,
                                    ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: TextFormField(
                            controller: textController2,
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                              hintText: 'Enter Your Password',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () =>
                                      passwordVisibility = !passwordVisibility,
                                ),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Color(0xFF757575),
                                  size: 22,
                                ),
                              ),
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF292929),
                                      fontSize: 16,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: FFButtonWidget(
                        onPressed: () async {
                          // await Navigator.push(
                          //  context,
                          // MaterialPageRoute(
                          //  builder: (context) =>
                          //   NavBarPage(initialPage: 'Landing'),
                          //  ),
                          // );

                          final String url =
                              "${ApiService.domain}/login/member";
                          final res = await http.post(Uri.parse(url), body: {
                            "mobile": textController1.text,
                            "password": textController2.text,
                            "device_token": FFAppState().FCM
                          });
                          final result = jsonDecode(res.body);
                          // print(data?.jsonBody[0].runtimeType);

                          //if ((getJsonField(
                          //  (data?.jsonBody ?? ''),
                          //  r'''$[:].Error''',
                          //)) ==
                          // ('Nill'))

                          print("this is the status code");
                          print(res.statusCode);
                          if (res.statusCode == 200) {
                            final data = jsonDecode(res.body);
                            // print(data["access_token"]);
                            FFAppState().Token = data["access_token"];
                            FFAppState().AccountId = data["master_obj_id"];
                            FFAppState().CurrentUserId = data["member_id"];
                            print(FFAppState().AccountId);
                            FFAppState().executive = data["execeutive"];
                            FFAppState().liveView =
                                data["permission"]["live_video"];
                            FFAppState().viewVideo =
                                data["permission"]["view_video"];
                            FFAppState().chat = data["permission"]["chat"];
                            print(FFAppState().chat);
                            print(FFAppState().executive);
                            print(FFAppState().Token);
                            Toast.showToast(context,
                                type: ToastType.Success,
                                message: result["message"]);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NavBarPage(initialPage: 'Landing'),
                              ),
                            );
                          } else if (textController1.text == "" &&
                              textController2.text == "") {
                            Toast.showToast(context,
                                type: ToastType.Error,
                                message:
                                    "Enter the mobile number and password");
                          } else if (textController1.text == "") {
                            Toast.showToast(context,
                                type: ToastType.Error,
                                message: "Enter the mobile number");
                          } else if (textController2.text == "") {
                            Toast.showToast(
                              context,
                              type: ToastType.Error,
                              message: "Enter the password",
                            );
                          } else {
                            Toast.showToast(
                              context,
                              type: ToastType.Error,
                              message: result["message"],
                            );
                          }

                          // setState(() {});
                        },
                        text: 'Login',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 50,
                          color: Color(0xFF00B89F),
                          textStyle: FlutterFlowTheme.of(context)
                              .subtitle2
                              .override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => forget_password(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFFAFAFAF),
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
