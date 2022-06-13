import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:n_tel_care_family_app/app_state.dart';
import 'package:n_tel_care_family_app/backend/api_requests/api_calls.dart';
import 'package:n_tel_care_family_app/flutter_flow/flutter_flow_theme.dart';
import 'package:n_tel_care_family_app/flutter_flow/flutter_flow_widgets.dart';
import 'package:n_tel_care_family_app/forgotPasword/forget_password.dart';
import 'package:http/http.dart' as http;
import 'newPassword.dart';
import 'package:fluttertoast/fluttertoast.dart';

class verification extends StatefulWidget {
  const verification({Key key}) : super(key: key);

  @override
  _Verification createState() => _Verification();
}

class _Verification extends State<verification> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _one = TextEditingController();
  final TextEditingController _two = TextEditingController();
  final TextEditingController _three = TextEditingController();
  final TextEditingController _four = TextEditingController();
  final TextEditingController _five = TextEditingController();
  final TextEditingController _six = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Image.asset(
                'assets/images/MicrosoftTeams-image.png',
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
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(7, 45, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => forget_password(),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.chevron_left_sharp,
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              size: 45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Verification',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFFE5E5E5),
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 20),
                    child: Text(
                      'Please Check you Mobile Phone for a Six-Digit Security Code and Enter Below',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFFE5E5E5),
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OtpInput(_one, true),
                      OtpInput(_two, false),
                      OtpInput(_three, false),
                      OtpInput(_four, false),
                      OtpInput(_five, false),
                      OtpInput(_six, false),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 20),
                    child: Text(
                      "Didn't receive a code? Resend code",
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Montserrat',
                            color: Color(0xFFE5E5E5),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                    child: FFButtonWidget(
                      onPressed: () async {
                        String otpA = _one.text +
                            _two.text +
                            _three.text +
                            _four.text +
                            _five.text +
                            _six.text;
                        final String url =
                            "http://18.208.148.208:4000/verifyotp/member";
                        final res = await http.post(Uri.parse(url),
                            body: {"email": FFAppState().Email, "otp": otpA});
                        final result = jsonDecode(res.body);
                        if (res.statusCode == 200) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text(result["message"])),
                          // );
                          Fluttertoast.showToast(
                              msg: result["message"],
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.grey,
                              textColor: Colors.black,
                              fontSize: 14.0);
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => newPassword(),
                            ),
                          );
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text(result["message"]),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        }

                        setState(() {});
                      },
                      text: 'Verify',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50,
                        color: Color(0xFF00B89F),
                        textStyle: FlutterFlowTheme.of(context)
                            .subtitle2
                            .override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFFF3F4F4),
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
