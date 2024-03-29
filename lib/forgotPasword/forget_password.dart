//import 'package:n_tel_care_family_app/model/loginmodel.dart';
import 'dart:convert';

import 'package:n_tel_care_family_app/backend/ApiService.dart';
import 'package:n_tel_care_family_app/forgotPasword/verification.dart';
import 'package:n_tel_care_family_app/login/login_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class forget_password extends StatefulWidget {
  const forget_password({Key key}) : super(key: key);

  @override
  _forget_passwordState createState() => _forget_passwordState();
}

class _forget_passwordState extends State<forget_password> {
  TextEditingController textController1;

  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();

    passwordVisibility = false;
  }

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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 20),
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                          child: Text(
                            'Forgot Password',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFFE5E5E5),
                                      fontSize: 20,
                                    ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: TextFormField(
                                controller: textController1,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Mobile Number',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                  hintText: 'Enter Your Mobile Number',
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
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF292929),
                                      fontSize: 16,
                                    ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ),

                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                        //   child: Container(
                        //     width: double.infinity,
                        //     decoration: BoxDecoration(
                        //       color: Color(0xFFEEEEEE),
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     child: Padding(
                        //       padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        //       child: TextFormField(
                        //         controller: textController2,
                        //         obscureText: !passwordVisibility,
                        //         decoration: InputDecoration(
                        //           labelText: 'Password',
                        //           labelStyle: FlutterFlowTheme.of(context)
                        //               .bodyText1
                        //               .override(
                        //                 fontFamily: 'Poppins',
                        //                 fontSize: 12,
                        //                 fontWeight: FontWeight.w300,
                        //               ),
                        //           hintText: 'Enter Your Password',
                        //           enabledBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(
                        //               color: Color(0x00000000),
                        //               width: 1,
                        //             ),
                        //             borderRadius: const BorderRadius.only(
                        //               topLeft: Radius.circular(4.0),
                        //               topRight: Radius.circular(4.0),
                        //             ),
                        //           ),
                        //           focusedBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(
                        //               color: Color(0x00000000),
                        //               width: 1,
                        //             ),
                        //             borderRadius: const BorderRadius.only(
                        //               topLeft: Radius.circular(4.0),
                        //               topRight: Radius.circular(4.0),
                        //             ),
                        //           ),
                        //           suffixIcon: InkWell(
                        //             onTap: () => setState(
                        //               () =>
                        //                   passwordVisibility = !passwordVisibility,
                        //             ),
                        //             child: Icon(
                        //               passwordVisibility
                        //                   ? Icons.visibility_outlined
                        //                   : Icons.visibility_off_outlined,
                        //               color: Color(0xFF757575),
                        //               size: 22,
                        //             ),
                        //           ),
                        //         ),
                        //         style:
                        //             FlutterFlowTheme.of(context).bodyText1.override(
                        //                   fontFamily: 'Poppins',
                        //                   color: Color(0xFF292929),
                        //                   fontSize: 16,
                        //                 ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                          child: FFButtonWidget(
                            onPressed: () async

                                // {
                                //await Navigator.push(
                                // context,
                                //   MaterialPageRoute(
                                //   builder: (context) => verification(),
                                // ),
                                //  );
                                // },

                                {
                              if (textController1.text == "") {
                                Fluttertoast.showToast(
                                    msg: "Please provide Mobile Number",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.black,
                                    fontSize: 14.0);
                              } else {
                                final String url =
                                    "${ApiService.domain}/forget/member";
                                final res =
                                    await http.post(Uri.parse(url), body: {
                                  "mobile": textController1.text,
                                });
                                final result = jsonDecode(res.body);
                                if (res.statusCode == 200) {
                                  FFAppState().Mobile = textController1.text;

                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  // SnackBar(content: Text(result["message"])),
                                  // );
                                  Fluttertoast.showToast(
                                      msg: result["message"],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.black,
                                      fontSize: 14.0);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => verification(),
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
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            text: 'Send Temporary Password',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 50,
                              color: Color(0xFF00B89F),
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFFF3F4F4),
                                      fontWeight: FontWeight.bold),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                          ),
                        ),
                        /*  InkWell(
                           onTap: () async {
                            await ForgotPasswordCall.call(
                               email: FFAppState().Email,
                             );
                          },
                           child: Text(
                            'Forgot Password?',
                           style: FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                 color: Color(0xFFAFAFAF),
                                 ),
                          ),
                        ),*/
                      ],
                    ),
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
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
                                      builder: (context) => LoginWidget(),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.chevron_left_sharp,
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  size: 45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])
              ],
            ),
          ),
        ));
  }
}
