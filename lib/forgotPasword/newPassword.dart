import 'dart:convert';

import 'package:n_tel_care_family_app/forgotPasword/forget_password.dart';
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

class newPassword extends StatefulWidget {
  const newPassword({Key key}) : super(key: key);

  @override
  _newPasswordState createState() => _newPasswordState();
}

class _newPasswordState extends State<newPassword> {
  TextEditingController textController1;
  TextEditingController textController2;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility = false;
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
                                builder: (context) => verification(),
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
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 65),
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
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 10),
                      child: Text(
                        'Forgot Password',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 20,
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
                            controller: textController1,
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                              hintText: 'Enter Your New Password',
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
                              labelText: 'Confirm Password',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                              hintText: 'Enter Your Password Again',
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
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (textController1.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Complete the details")),
                            );
                          } else {
                            final String url =
                                "http://18.208.148.208:4000/reset/member";
                            final res = await http.post(Uri.parse(url), body: {
                              "mobile": FFAppState().Mobile,
                              "password": textController1.text,
                              "confirm_password": textController2.text
                            });
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
                                  builder: (context) => LoginWidget(),
                                ),
                              );
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text(result['message']),
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
                            //   final data = await LoginCall.call(
                            //     username: textController1.text,
                            //     password: textController2.text,
                            //   );
                            //   print(data?.jsonBody[0].runtimeType);

                            //   if ((getJsonField(
                            //         (data?.jsonBody ?? ''),
                            //         r'''$[:].Error''',
                            //       )) ==
                            //       ('Nill')) {
                            //     LoginModel loginModel =
                            //         LoginModel.fromJsonData(data.jsonBody[0]);
                            //     FFAppState().IsUserLogin = loginModel.IsUserLogin;
                            //     FFAppState().IsLiveView = loginModel.IsLiveView;
                            //     FFAppState().Error = loginModel.Error;
                            //     FFAppState().Email = loginModel.Email;
                            //     FFAppState().Token = loginModel.Token;
                            //     FFAppState().UserId = loginModel.UserId;
                            //     FFAppState().AccountId = loginModel.AccountId;
                            //     FFAppState().RoleId = loginModel.RoleId;
                            //     FFAppState().First_Name = loginModel.FirstName;
                            //     FFAppState().Last_Name = loginModel.LastName;
                            //     FFAppState().Profile_Picture =
                            //         loginModel.ProfilePicture;

                            //     print(loginModel.FirstName);
                            //     await Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) =>
                            //             NavBarPage(initialPage: 'Landing'),
                            //       ),
                            //     );
                            //   } else {
                            //     await showDialog(
                            //       context: context,
                            //       builder: (alertDialogContext) {
                            //         return AlertDialog(
                            //           title: Text('Error'),
                            //           content:
                            //               Text("Incorrect Username or Password"),
                            //           actions: [
                            //             TextButton(
                            //               onPressed: () =>
                            //                   Navigator.pop(alertDialogContext),
                            //               child: Text('Ok'),
                            //             ),
                            //           ],
                            //         );
                            //       },
                            //     );
                            //   }

                            //   setState(() {});
                          }
                        },
                        text: 'Confirm',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 50,
                          color: Color(0xFF00B89F),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
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
