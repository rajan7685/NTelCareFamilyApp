import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:n_tel_care_family_app/backend/api_requests/api_calls.dart';
import 'package:n_tel_care_family_app/components/custom_toast.dart';
import 'package:n_tel_care_family_app/critical/critical_widget.dart';
import 'package:n_tel_care_family_app/custom_code/widgets/custom_message.dart';
import 'package:n_tel_care_family_app/edit/demo_editProfile.dart';
import 'package:n_tel_care_family_app/login/login_widget.dart';
import 'package:n_tel_care_family_app/profile/help.dart';
import 'package:n_tel_care_family_app/seniors_list/senior_list.dart';
import 'package:http/http.dart' as http;

import '../chat/chat_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({Key key, this.ChatToggle}) : super(key: key);
  final bool ChatToggle;
  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  bool switchListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<dynamic> SList;
  List<dynamic> countries = [];
  dynamic inf;

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
      Toast.showToast(context,
          message: 'You are not connected to internet.', type: ToastType.Error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkNetworkConnectivity();
    SList = fetchSList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF1F252B),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 100,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Color(0xFF1F252B),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: Image.asset(
                          'assets/images/Group 1550.png',
                        ).image,
                      ),
                    ),
                    child: FutureBuilder<dynamic>(
                      future: SList,
                      builder: (context, snapshot) {
                        inf = snapshot.data;

                        print(FFAppState().relation);
                        if (!snapshot.hasData) {
                          return Text(
                            "Loading",
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFE5E5E5),
                                    fontSize: 20),
                          );
                        } else {
                          FFAppState().relation = snapshot.data["relation"];
                          countries = snapshot.data["countries"];
                          //print("snap shot countries : ${}");
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment:
                                        AlignmentDirectional(-0.03, -0.55),
                                    child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 55, 0, 0),
                                        child: Container(
                                          width: 175,
                                          height: 175,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: Image.network(snapshot
                                                              .data["member"]
                                                          ["profile"] ??
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYL2_7f_QDJhq5m9FYGrz5W4QI5EUuDLSdGA&usqp=CAU")
                                                  .image,
                                            ),
                                          ),
                                        )),
                                  ),
                                  if (snapshot.data["member"]["executive"])
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  100, 180, 0, 0),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF00B89F),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/achievment.svg',
                                                  width: 25,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        7, 45, 10, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(0x00707373),
                                            shape: BoxShape.circle,
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CriticalWidget(),
                                                ),
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0x0000FFFF),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Icon(
                                                      Icons.notifications_none,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .tertiaryColor,
                                                      size: 35,
                                                    ),
                                                  ),
                                                ),
                                                // Align(
                                                //   alignment:
                                                //       AlignmentDirectional(
                                                //           0.05, -0.43),
                                                //   child: Padding(
                                                //     padding:
                                                //         EdgeInsetsDirectional
                                                //             .fromSTEB(
                                                //                 17, 0, 0, 0),
                                                //     child: Container(
                                                //       width: 15,
                                                //       height: 15,
                                                //       decoration: BoxDecoration(
                                                //         color:
                                                //             Color(0xFF006B5D),
                                                //         shape: BoxShape.circle,
                                                //       ),
                                                //       child: Row(
                                                //         mainAxisSize:
                                                //             MainAxisSize.max,
                                                //         mainAxisAlignment:
                                                //             MainAxisAlignment
                                                //                 .center,
                                                //         children: [
                                                //           Text(
                                                //             '5',
                                                //             style: FlutterFlowTheme
                                                //                     .of(context)
                                                //                 .bodyText1
                                                //                 .override(
                                                //                   fontFamily:
                                                //                       'Montserrat',
                                                //                   color: Colors
                                                //                       .white,
                                                //                   fontSize: 8,
                                                //                   fontWeight:
                                                //                       FontWeight
                                                //                           .bold,
                                                //                 ),
                                                //           ),
                                                //         ],
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.3, 0.25),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 15, 0, 0),
                                      child: Text(
                                        snapshot.data["member"]["fname"] +
                                            " " +
                                            snapshot.data["member"]["lname"],
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryColor,
                                              fontSize: 25,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.08, 0.71),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 0),
                                      child: Text(
                                        // snapshot.data["member"]["age"]
                                        //         .toString() +
                                        //     "," +
                                        //     snapshot.data["member"]["sex"]
                                        // ,
                                        'Age ${snapshot.data["member"]["age"]}, ${snapshot.data["member"]["sex"]}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFFAFAFAF),
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.mail_outline,
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryColor,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Align(
                                    // alignment: AlignmentDirectional(0.08, 0.71),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Text(
                                        snapshot.data["member"]["email"],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.phone_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.08, 0.71),
                                      child: Text(
                                        snapshot.data["member"]["mobile"],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryColor,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.08, 0.71),
                                      child: Text(
                                        snapshot.data["member"]["address"] +
                                            " " +
                                            snapshot.data["member"]["zipcode"],
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryColor,
                                              fontSize: 12,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),

                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF1F252B),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (FFAppState().chat ?? true)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                        child: SvgPicture.asset(
                                          'assets/images/353430_checkbox_pen_edit_pencil_icon.svg',
                                          width: 21,
                                          height: 21,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  17, 0, 0, 0),
                                          child: SwitchListTile(
                                            value: FFAppState().Chattoggle2,
                                            onChanged: (bool value) => setState(
                                                () => FFAppState().Chattoggle2 =
                                                    value),
                                            title: Text(
                                              'Enable Chat',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .title3
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFFAFAFAF),
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                            ),
                                            tileColor: Color(0xFFF5F5F5),
                                            activeColor: Color(0xFFECECEC),
                                            activeTrackColor: Color(0xFF00B89F),
                                            dense: false,
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 10, 0),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SeniorsWidget(),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.location_history,
                                      color: Color(0xFF00B89F),
                                      size: 25,
                                    ),
                                    title: Text(
                                      'Seniors',
                                      style: FlutterFlowTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFFAFAFAF),
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xFF00B89F),
                                      size: 25,
                                    ),
                                    tileColor: Color(0xFFF5F5F5),
                                    dense: false,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 10, 0),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditCopy2Widget(
                                            info: inf, countries: countries),
                                      ),
                                    );
                                    setState(() {
                                      SList = fetchSList();
                                    });
                                  },
                                  child: ListTile(
                                    leading: FaIcon(
                                      FontAwesomeIcons.edit,
                                      color: Color(0xFF00B89F),
                                      size: 20,
                                    ),
                                    title: Text(
                                      'Edit Profile',
                                      style: FlutterFlowTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFFAFAFAF),
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xFF00B89F),
                                      size: 25,
                                    ),
                                    tileColor: Color(0xFFF5F5F5),
                                    dense: false,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 10, 0),
                                child: InkWell(
                                  onTap: () async {
                                    print("presses");
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return CustomMessage(
                                          title: ("Are you sure?"),
                                          content:
                                              ("Are you sure you want to logout?"),
                                          onpressed: () async {
                                            await Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginWidget(),
                                              ),
                                              (r) => false,
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: ListTile(
                                    /*leading: Icon(
                                  Icons.logout,
                                  color: Color(0xFF00B89F),
                                  size: 25,
                                ),*/
                                    leading: SvgPicture.asset(
                                      'assets/images/logout.svg',
                                      width: 21,
                                      height: 21,
                                      fit: BoxFit.fill,
                                    ),
                                    title: Text(
                                      'Logout',
                                      style: FlutterFlowTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFFAFAFAF),
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xFF00B89F),
                                      size: 25,
                                    ),
                                    tileColor: Color(0xFFF5F5F5),
                                    dense: false,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 10, 0),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SpalshWidget(),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.help,
                                      color: Color(0xFF00B89F),
                                      size: 25,
                                    ),
                                    title: Text(
                                      'Help',
                                      style: FlutterFlowTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFFAFAFAF),
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xFF00B89F),
                                      size: 25,
                                    ),
                                    tileColor: Color(0xFFF5F5F5),
                                    dense: false,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(10, 0, 40, 85),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 35, 0),
                  //         child: InkWell(
                  //           onTap: () async {
                  //             await Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) => ChatWidget(),
                  //               ),
                  //             );
                  //           },
                  //           child: Column(
                  //             mainAxisSize: MainAxisSize.max,
                  //             children: [
                  //               Container(
                  //                 width: 60,
                  //                 height: 60,
                  //                 decoration: BoxDecoration(
                  //                   color: Color(0xFF1F252B),
                  //                   shape: BoxShape.circle,
                  //                 ),
                  //                 child: Stack(
                  //                   children: [
                  //                     Container(
                  //                       width: 60,
                  //                       height: 60,
                  //                       decoration: BoxDecoration(
                  //                         color: Color(0xFF00B89F),
                  //                         shape: BoxShape.circle,
                  //                       ),
                  //                       child: Column(
                  //                         mainAxisSize: MainAxisSize.max,
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         children: [
                  //                           Image.asset(
                  //                             'assets/images/bubble.png',
                  //                             width: 40,
                  //                             height: 40,
                  //                             fit: BoxFit.fill,
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     Align(
                  //                       alignment:
                  //                           AlignmentDirectional(1.31, -0.83),
                  //                       child: Container(
                  //                         width: 20,
                  //                         height: 20,
                  //                         decoration: BoxDecoration(
                  //                           color: Color(0xFFEEEEEE),
                  //                           shape: BoxShape.circle,
                  //                         ),
                  //                         child: Row(
                  //                           mainAxisSize: MainAxisSize.min,
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.center,
                  //                           children: [
                  //                             Text(
                  //                               '5',
                  //                               textAlign: TextAlign.center,
                  //                               style: FlutterFlowTheme.of(context)
                  //                                   .bodyText1
                  //                                   .override(
                  //                                     fontFamily: 'Montserrat',
                  //                                     color: Color(0xFF00B89F),
                  //                                     fontWeight: FontWeight.bold,
                  //                                   ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               Text(
                  //                 'Family Chat',
                  //                 style: FlutterFlowTheme.of(context)
                  //                     .bodyText1
                  //                     .override(
                  //                       fontFamily: 'Montserrat',
                  //                       color: Color(0xFFE5E5E5),
                  //                       fontWeight: FontWeight.w100,
                  //                     ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // Padding(
                  //   padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Padding(
                  //         padding:
                  //             EdgeInsetsDirectional.fromSTEB(0, 0, 100, 100),
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.max,
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             if (FFAppState().Chattoggle2 &&
                  //                 FFAppState().executive)
                  //               Padding(
                  //                 padding: EdgeInsetsDirectional.fromSTEB(
                  //                     0, 10, 15, 0),
                  //                 child: InkWell(
                  //                   onTap: () async {
                  //                     await Navigator.push(
                  //                       context,
                  //                       MaterialPageRoute(
                  //                         builder: (context) => ChatWidget(),
                  //                       ),
                  //                     );
                  //                   },
                  //                   child: Column(
                  //                     mainAxisSize: MainAxisSize.max,
                  //                     children: [
                  //                       Container(
                  //                         width: 60,
                  //                         height: 60,
                  //                         decoration: BoxDecoration(
                  //                           color: Color(0xFFEEEEEE),
                  //                           shape: BoxShape.circle,
                  //                         ),
                  //                         child: Stack(
                  //                           children: [
                  //                             Container(
                  //                               width: 60,
                  //                               height: 60,
                  //                               decoration: BoxDecoration(
                  //                                 color: Color(0xFF00B89F),
                  //                                 shape: BoxShape.circle,
                  //                               ),
                  //                               child: Column(
                  //                                 mainAxisSize:
                  //                                     MainAxisSize.max,
                  //                                 mainAxisAlignment:
                  //                                     MainAxisAlignment.center,
                  //                                 children: [
                  //                                   Image.asset(
                  //                                     'assets/images/bubble.png',
                  //                                     width: 40,
                  //                                     height: 40,
                  //                                     fit: BoxFit.fill,
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                             Align(
                  //                               alignment: AlignmentDirectional(
                  //                                   1.31, -0.83),
                  //                               child: Container(
                  //                                 width: 20,
                  //                                 height: 20,
                  //                                 decoration: BoxDecoration(
                  //                                   color: Color(0xFFEEEEEE),
                  //                                   shape: BoxShape.circle,
                  //                                 ),
                  //                                 child: Row(
                  //                                   mainAxisSize:
                  //                                       MainAxisSize.min,
                  //                                   mainAxisAlignment:
                  //                                       MainAxisAlignment
                  //                                           .center,
                  //                                   children: [
                  //                                     Text(
                  //                                       '5',
                  //                                       textAlign:
                  //                                           TextAlign.center,
                  //                                       style:
                  //                                           FlutterFlowTheme.of(
                  //                                                   context)
                  //                                               .bodyText1
                  //                                               .override(
                  //                                                 fontFamily:
                  //                                                     'Montserrat',
                  //                                                 color: Color(
                  //                                                     0xFF00B89F),
                  //                                                 fontWeight:
                  //                                                     FontWeight
                  //                                                         .bold,
                  //                                               ),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       Text(
                  //                         'Family Chat',
                  //                         style: FlutterFlowTheme.of(context)
                  //                             .bodyText1
                  //                             .override(
                  //                               fontFamily: 'Montserrat',
                  //                               color: Color(0xFFE5E5E5),
                  //                               fontWeight: FontWeight.w100,
                  //                             ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 100)
                ],
              ),
            ]),
          ),
        ),
        floatingActionButton: (FFAppState().Chattoggle2 && FFAppState().chat)
            ? Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 100, 80),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 15, 0),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatWidget(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEEEEEE),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF00B89F),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/bubble.png',
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.fill,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Align(
                                        //   alignment:
                                        //       AlignmentDirectional(1.31, -0.83),
                                        //   child: Container(
                                        //     width: 20,
                                        //     height: 20,
                                        //     decoration: BoxDecoration(
                                        //       color: Color(0xFFEEEEEE),
                                        //       shape: BoxShape.circle,
                                        //     ),
                                        //     child: Row(
                                        //       mainAxisSize: MainAxisSize.min,
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.center,
                                        //       children: [
                                        //         Text(
                                        //           '5',
                                        //           textAlign: TextAlign.center,
                                        //           style: FlutterFlowTheme.of(
                                        //                   context)
                                        //               .bodyText1
                                        //               .override(
                                        //                 fontFamily:
                                        //                     'Montserrat',
                                        //                 color:
                                        //                     Color(0xFF00B89F),
                                        //                 fontWeight:
                                        //                     FontWeight.bold,
                                        //               ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Family Chat',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFFE5E5E5),
                                          fontWeight: FontWeight.w100,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  Future fetchSList() async {
    final ApiCallResponse SList = await GetProfile.call();

    print(SList.statusCode);
    //print(SList["relation"]);

    return SList.jsonBody;
  }
}
