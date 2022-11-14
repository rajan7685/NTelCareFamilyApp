import 'dart:convert';

import 'package:n_tel_care_family_app/backend/api_requests/api_calls.dart';
import 'package:n_tel_care_family_app/backend/api_requests/api_manager.dart';
import 'package:n_tel_care_family_app/critical/critical_widget.dart';
import 'package:n_tel_care_family_app/profile/profile_page.dart';
import 'package:n_tel_care_family_app/seniors_list/edit_seniors.dart';
import 'package:http/http.dart' as http;
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeniorsWidget extends StatefulWidget {
  const SeniorsWidget({Key key}) : super(key: key);

  @override
  _SeniorsWidgetState createState() => _SeniorsWidgetState();
}

class _SeniorsWidgetState extends State<SeniorsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<dynamic> SList;
  List<dynamic> countries = [];
  @override
  void initState() {
    super.initState();
    SList = fetchSList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFF1F252B),
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(7, 30, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_sharp,
                                  color: Colors.white,
                                  size: 26,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  /*Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: Color(0xFF00B89F),
                                  size: 30,
                                ),
                              ),*/
                                  InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CriticalWidget(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1F252B),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFF1F252B),
                                            ),
                                            child: Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Icon(
                                                Icons.notifications_none,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                          // Align(
                                          //   alignment: AlignmentDirectional(
                                          //       0.05, -0.43),
                                          //   child: Padding(
                                          //     padding: EdgeInsetsDirectional
                                          //         .fromSTEB(17, 0, 0, 0),
                                          //     child: Container(
                                          //       width: 15,
                                          //       height: 15,
                                          //       decoration: BoxDecoration(
                                          //         color: Color(0xFF006B5D),
                                          //         shape: BoxShape.circle,
                                          //       ),
                                          //       child: Row(
                                          //         mainAxisSize:
                                          //             MainAxisSize.max,
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment.center,
                                          //         children: [
                                          //           Text(
                                          //             '5',
                                          //             style: FlutterFlowTheme
                                          //                     .of(context)
                                          //                 .bodyText1
                                          //                 .override(
                                          //                   fontFamily:
                                          //                       'Montserrat',
                                          //                   color: Colors.white,
                                          //                   fontSize: 8,
                                          //                   fontWeight:
                                          //                       FontWeight.bold,
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
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 1),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 10),
                              child: Text(
                                'Seniors',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFFAFAFAF),
                                      fontSize: 40,
                                      fontWeight: FontWeight.w200,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 9, 0, 0),
                            child: FutureBuilder<dynamic>(
                                future: SList,
                                builder: (context, snapshot) {
                                  final inf = snapshot.data;

                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  } else {
                                    return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 10, 5, 0),
                                            child: InkWell(
                                              onTap: () async {
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditSeniorsWidget(
                                                              data: snapshot
                                                                  .data[index],
                                                              countries:
                                                                  countries),
                                                    ));
                                                setState(() {
                                                  SList = fetchSList();
                                                });
                                              },
                                              child: Card(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                color: Color(0xFF272E36),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(3, 0, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 80,
                                                        height: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF272E36),
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          5,
                                                                          0,
                                                                          5),
                                                              child: Container(
                                                                width: 100,
                                                                height: 100,
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Image
                                                                    .network(
                                                                  snapshot.data[
                                                                              index]
                                                                          [
                                                                          "profile"] ??
                                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYL2_7f_QDJhq5m9FYGrz5W4QI5EUuDLSdGA&usqp=CAU",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
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
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
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
                                                                        inf[index]["fname"] +
                                                                            " " +
                                                                            inf[index]["lname"],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              color: Color(0xFF00B89F),
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .mail_outline,
                                                                        color: Color(
                                                                            0xFF00B89F),
                                                                        size:
                                                                            12,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            6,
                                                                      ),
                                                                      Text(
                                                                        inf[index]
                                                                            [
                                                                            "email"],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
                                                                              color: Color(0xFFAFAFAF),
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w200,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2,
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .phone_outlined,
                                                                        color: Color(
                                                                            0xFF00B89F),
                                                                        size:
                                                                            12,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            6,
                                                                      ),
                                                                      Text(
                                                                        inf[index]["mobile"] !=
                                                                                null
                                                                            ? inf[index]["mobile"]
                                                                            : "",
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Montserrat',
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
                                                            Icon(
                                                              Icons
                                                                  .chevron_right,
                                                              color: Color(
                                                                  0xFF00B89F),
                                                              size: 30,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future fetchSList() async {
    final ApiCallResponse SList = await SeniorsList.call();
    print(SList.statusCode);
    print(SList.jsonBody["countries"]);
    print(SList.jsonBody["seniors"]);
    countries = SList.jsonBody["countries"];
    return SList.jsonBody["seniors"];
  }
}
