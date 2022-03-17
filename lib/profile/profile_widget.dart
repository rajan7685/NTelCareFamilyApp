import 'package:n_tel_care_family_app/backend/api_requests/api_calls.dart';
import 'package:n_tel_care_family_app/login/login_widget.dart';

import '../components/switch_chat_widget.dart';
import '../edit/edit_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../login/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key key,
    this.chattoggle,
  }) : super(key: key);

  final bool chattoggle;

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00B89F), Color(0xFF005C50)],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0.77, -1),
                      end: AlignmentDirectional(-0.77, 1),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF292929),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          color: Color(0xFFE5E5E5),
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.asset(
                                        'assets/images/Screenshot_2022-02-17_213808.jpg',
                                      ).image,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.35, 0.35),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 20, 0, 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.network(
                                        FFAppState().Profile_Picture,
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  FFAppState().First_Name,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      FFAppState().Last_Name,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    FFAppState().Email,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontWeight: FontWeight.w200,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    '8439999116',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontWeight: FontWeight.w200,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.6, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditWidget(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.edit,
                                        color: Color(0xFF00FFDC),
                                        size: 14,
                                      ),
                                      Text(
                                        ' Edit Profile',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryColor,
                                              fontWeight: FontWeight.w200,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '--------------',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryColor,
                                      ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginWidget(),
                                  ),
                                  (r) => false,
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Color(0xFF00FFDC),
                                    size: 16,
                                  ),
                                  Text(
                                    '  Logout',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          fontWeight: FontWeight.w200,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 45, 5, 0),
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFF292929),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                onTap: () async {
                                  setState(
                                      () => FFAppState().Chattoggle2 = false);
                                },
                                child: SwitchChatWidget(),
                              ),
                              Divider(
                                thickness: 2,
                                indent: 15,
                                endIndent: 15,
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 15, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Users',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFE5E5E5),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditWidget(),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: Color(0xFF262626),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(3, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF262626),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Card(
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          color:
                                                              Color(0xFF1A1A1A),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -0.06, -0.12),
                                                          child: Image.asset(
                                                            'assets/images/Group_702.png',
                                                            width: 35,
                                                            height: 35,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(10,
                                                                      0, 0, 0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'Ronny',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Color(0xFFE5E5E5),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'ronn@gmail.com',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              Color(0xFFAFAFAF),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w200,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    '+16549873214',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              Color(0xFFAFAFAF),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.chevron_right,
                                                          color:
                                                              Color(0xFFAFAFAF),
                                                          size: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditWidget(),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: Color(0xFF262626),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(3, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF262626),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Card(
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          color:
                                                              Color(0xFF1A1A1A),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -0.06, -0.12),
                                                          child: Image.asset(
                                                            'assets/images/Group_702.png',
                                                            width: 35,
                                                            height: 35,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(10,
                                                                      0, 0, 0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'Ronny',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Color(0xFFE5E5E5),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'ronn@gmail.com',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              Color(0xFFAFAFAF),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w200,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    '+16549873214',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              Color(0xFFAFAFAF),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.chevron_right,
                                                          color:
                                                              Color(0xFFAFAFAF),
                                                          size: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditWidget(),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: Color(0xFF262626),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(3, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF262626),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Card(
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          color:
                                                              Color(0xFF1A1A1A),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -0.06, -0.12),
                                                          child: Image.asset(
                                                            'assets/images/Group_702.png',
                                                            width: 35,
                                                            height: 35,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(10,
                                                                      0, 0, 0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'Ronny',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Color(0xFFE5E5E5),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'ronn@gmail.com',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              Color(0xFFAFAFAF),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w200,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    '+16549873214',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              Color(0xFFAFAFAF),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.chevron_right,
                                                          color:
                                                              Color(0xFFAFAFAF),
                                                          size: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditWidget(),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: Color(0xFF262626),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(3, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF262626),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Card(
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          color:
                                                              Color(0xFF1A1A1A),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -0.06, -0.12),
                                                          child: Image.asset(
                                                            'assets/images/Group_702.png',
                                                            width: 35,
                                                            height: 35,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(10,
                                                                      0, 0, 0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'Ronny',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Color(0xFFE5E5E5),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'ronn@gmail.com',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              Color(0xFFAFAFAF),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w200,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    '+16549873214',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              Color(0xFFAFAFAF),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.chevron_right,
                                                          color:
                                                              Color(0xFFAFAFAF),
                                                          size: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 70),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 25, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditWidget(),
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
                                  color: Color(0xFF00B89F),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  size: 50,
                                ),
                              ),
                              Text(
                                'Add User',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
