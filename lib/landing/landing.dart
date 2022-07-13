import 'package:flutter/rendering.dart';
import 'package:n_tel_care_family_app/backend/api_requests/api_calls.dart';
import 'package:n_tel_care_family_app/critical/critical_widget.dart';
import 'package:n_tel_care_family_app/stats/battery.dart';
import 'package:n_tel_care_family_app/stats/blood_pressure.dart';
import 'package:n_tel_care_family_app/stats/calorie.dart';
import 'package:n_tel_care_family_app/stats/door.dart';
import 'package:n_tel_care_family_app/stats/oxygen.dart';
import 'package:n_tel_care_family_app/stats/pill.dart';
import 'package:n_tel_care_family_app/stats/shower.dart';
import 'package:n_tel_care_family_app/stats/sleep.dart';
import 'package:n_tel_care_family_app/stats/heart.dart';
import 'package:n_tel_care_family_app/seniors_list/edit_seniors.dart';
import 'package:n_tel_care_family_app/stats/step.dart';
import 'dart:async';
import '../chat/chat_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ModifiedLandingPageWidget extends StatefulWidget {
  const ModifiedLandingPageWidget({Key key}) : super(key: key);

  @override
  _ModifiedLandingPageWidgetState createState() =>
      _ModifiedLandingPageWidgetState();
}

class _ModifiedLandingPageWidgetState extends State<ModifiedLandingPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<dynamic> SList;
  var selectedId;
  int isSelected = 0;
  var selList = Colors.red;
  dynamic data;

  _isSelected(int index) {
    setState(() {
      isSelected = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    SList = fetchSList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await fetchDashData(selectedId);
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF1F252B),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsetsDirectional.only(bottom: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(7, 31, 10, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CriticalWidget(),
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
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Icon(
                                          Icons.notifications_none,
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryColor,
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.05, -0.43),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            17, 0, 0, 0),
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF006B5D),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '5',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: Colors.white,
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ],
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
                      RefreshIndicator(
                        onRefresh: () async {
                          await fetchDashData(selectedId);
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFF1F252B),
                          ),
                          child: FutureBuilder<dynamic>(
                              future: SList,
                              builder: (context, snapshot) {
                                final inf = snapshot.data;
                                print(inf);
                                // setState(() {
                                //   selectedId = inf[0]["id"];
                                // });
                                if (!snapshot.hasData) {
                                  return Text(
                                    "Loading...",
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFE5E5E5),
                                            fontSize: 20),
                                  );
                                } else {
                                  Future.delayed(Duration(seconds: 1), () {
                                    setState(() {
                                      selectedId = inf[0]["id"];
                                    });
                                  });

                                  return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final id = inf[index]["id"];
                                        FFAppState().id = id;
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 10, 0),
                                          child: Container(
                                            decoration: BoxDecoration(

                                                // Colors.transparent

                                                //Color(0xFF1F252B).withOpacity(1),
                                                ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedId = id;
                                                    });
                                                    fetchDashData(selectedId);
                                                    _isSelected(index);
                                                  },
                                                  child: Container(
                                                    width: 70,
                                                    height: 70,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: isSelected == true
                                                          ? Colors.red
                                                          : Colors.black,
                                                    ),
                                                    child: Image.network(
                                                      inf[index]["profile"],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 0, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 20,
                                                                    0, 0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              inf[index][
                                                                      "fname"] +
                                                                  " " +
                                                                  inf[index]
                                                                      ["lname"],
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: isSelected !=
                                                                                null &&
                                                                            isSelected ==
                                                                                index
                                                                        ? Color(
                                                                            0xFF00B89F)
                                                                        : Color(
                                                                            0xFF535353),
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        2,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              "Age " +
                                                                  inf[index]
                                                                      ["age"] +
                                                                  ", " +
                                                                  inf[index][
                                                                      "gender"],
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: isSelected !=
                                                                                null &&
                                                                            isSelected ==
                                                                                index
                                                                        ? Color(
                                                                            0xFFE5E5E5)
                                                                        : Color(
                                                                            0xFF535353),
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w200,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      EditSeniorsWidget(
                                                                          data:
                                                                              snapshot.data[index])));
                                                          dashboard();
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          6,
                                                                          0,
                                                                          0),
                                                              child: Text(
                                                                'More Info',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      color: isSelected != null &&
                                                                              isSelected ==
                                                                                  index
                                                                          ? Colors
                                                                              .blue
                                                                          : Color(
                                                                              0xFF535353),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w200,
                                                                    ),
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
                                      });
                                }
                              }),
                        ),
                      ),
                      if (selectedId == null) CircularProgressIndicator(),
                      if (selectedId != null) dashboard(),
                      // if (selectedId != null)
                      //   FutureBuilder(
                      //       future: fetchDashData(selectedId),
                      //       builder: (context, snapshot) {
                      //         final info = snapshot.data;
                      //         print(info);
                      //         print(FFAppState().Steps);
                      //         return Padding(
                      //           padding:
                      //               EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.max,
                      //             children: [
                      //               Padding(
                      //                 padding: EdgeInsetsDirectional.fromSTEB(
                      //                     10, 0, 10, 10),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceAround,
                      //                   children: [
                      //                     Expanded(
                      //                       child: Container(
                      //                         decoration: BoxDecoration(
                      //                           color: Color(0xFF272E36),
                      //                           borderRadius:
                      //                               BorderRadius.circular(10),
                      //                         ),
                      //                         child: InkWell(
                      //                           onTap: () async {
                      //                             await Navigator.push(
                      //                               context,
                      //                               MaterialPageRoute(
                      //                                 builder: (context) =>
                      //                                     StatsWidget(
                      //                                         data: selectedId),
                      //                               ),
                      //                             );
                      //                           },
                      //                           child: Column(
                      //                             mainAxisSize:
                      //                                 MainAxisSize.max,
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment.end,
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               Stack(
                      //                                 children: [
                      //                                   Padding(
                      //                                     padding:
                      //                                         EdgeInsetsDirectional
                      //                                             .fromSTEB(15,
                      //                                                 0, 50, 0),
                      //                                     child: Column(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment
                      //                                               .start,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       10,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Row(
                      //                                             mainAxisSize:
                      //                                                 MainAxisSize
                      //                                                     .max,
                      //                                             children: [
                      //                                               Text(
                      //                                                 'Heart Rate',
                      //                                                 style: FlutterFlowTheme.of(
                      //                                                         context)
                      //                                                     .bodyText1
                      //                                                     .override(
                      //                                                       fontFamily:
                      //                                                           'Montserrat',
                      //                                                       color:
                      //                                                           Color(0xFF00B89F),
                      //                                                       fontSize:
                      //                                                           10,
                      //                                                       fontWeight:
                      //                                                           FontWeight.w300,
                      //                                                     ),
                      //                                               ),
                      //                                             ],
                      //                                           ),
                      //                                         ),
                      //                                         Row(
                      //                                           mainAxisSize:
                      //                                               MainAxisSize
                      //                                                   .max,
                      //                                           children: [
                      //                                             Text(
                      //                                               info["watch_status"]
                      //                                                       [
                      //                                                       'heart_rate'] +
                      //                                                   " bpm",
                      //                                               style: FlutterFlowTheme.of(
                      //                                                       context)
                      //                                                   .bodyText1
                      //                                                   .override(
                      //                                                     fontFamily:
                      //                                                         'Montserrat',
                      //                                                     color:
                      //                                                         Color(0xFFE5E5E5),
                      //                                                     fontSize:
                      //                                                         20,
                      //                                                     fontWeight:
                      //                                                         FontWeight.w200,
                      //                                                   ),
                      //                                             ),
                      //                                           ],
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               Column(
                      //                                 mainAxisSize:
                      //                                     MainAxisSize.max,
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment.end,
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .end,
                      //                                 children: [
                      //                                   Row(
                      //                                     mainAxisSize:
                      //                                         MainAxisSize.max,
                      //                                     mainAxisAlignment:
                      //                                         MainAxisAlignment
                      //                                             .spaceBetween,
                      //                                     crossAxisAlignment:
                      //                                         CrossAxisAlignment
                      //                                             .center,
                      //                                     children: [
                      //                                       Padding(
                      //                                         padding:
                      //                                             EdgeInsetsDirectional
                      //                                                 .fromSTEB(
                      //                                                     0,
                      //                                                     20,
                      //                                                     0,
                      //                                                     0),
                      //                                         child: Icon(
                      //                                           Icons
                      //                                               .arrow_forward_ios_sharp,
                      //                                           color: Color(
                      //                                               0xFF00B89F),
                      //                                           size: 35,
                      //                                         ),
                      //                                       ),
                      //                                       Padding(
                      //                                         padding:
                      //                                             EdgeInsetsDirectional
                      //                                                 .fromSTEB(
                      //                                                     0,
                      //                                                     1,
                      //                                                     0,
                      //                                                     0),
                      //                                         child:
                      //                                             Image.asset(
                      //                                           'assets/images/15-health.png',
                      //                                           height: 90,
                      //                                           fit:
                      //                                               BoxFit.fill,
                      //                                         ),
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       child: Padding(
                      //                         padding: EdgeInsetsDirectional
                      //                             .fromSTEB(10, 0, 0, 0),
                      //                         child: Container(
                      //                           decoration: BoxDecoration(
                      //                             color: Color(0xFF272E36),
                      //                             borderRadius:
                      //                                 BorderRadius.circular(10),
                      //                           ),
                      //                           child: InkWell(
                      //                             onTap: () async {
                      //                               await Navigator.push(
                      //                                 context,
                      //                                 MaterialPageRoute(
                      //                                   builder: (context) =>
                      //                                       OxygenWidget(),
                      //                                 ),
                      //                               );
                      //                             },
                      //                             child: Column(
                      //                               mainAxisSize:
                      //                                   MainAxisSize.max,
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment.end,
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                               children: [
                      //                                 Stack(
                      //                                   children: [
                      //                                     Row(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       15,
                      //                                                       0,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Column(
                      //                                             mainAxisSize:
                      //                                                 MainAxisSize
                      //                                                     .max,
                      //                                             crossAxisAlignment:
                      //                                                 CrossAxisAlignment
                      //                                                     .start,
                      //                                             children: [
                      //                                               Padding(
                      //                                                 padding: EdgeInsetsDirectional
                      //                                                     .fromSTEB(
                      //                                                         0,
                      //                                                         10,
                      //                                                         0,
                      //                                                         0),
                      //                                                 child:
                      //                                                     Row(
                      //                                                   mainAxisSize:
                      //                                                       MainAxisSize.max,
                      //                                                   children: [
                      //                                                     Text(
                      //                                                       'Blood Oxygen',
                      //                                                       style: FlutterFlowTheme.of(context).bodyText1.override(
                      //                                                             fontFamily: 'Montserrat',
                      //                                                             color: Color(0xFF00B89F),
                      //                                                             fontSize: 10,
                      //                                                             fontWeight: FontWeight.w300,
                      //                                                           ),
                      //                                                     ),
                      //                                                   ],
                      //                                                 ),
                      //                                               ),
                      //                                               Row(
                      //                                                 mainAxisSize:
                      //                                                     MainAxisSize
                      //                                                         .max,
                      //                                                 children: [
                      //                                                   Text(
                      //                                                     info["watch_status"]
                      //                                                         [
                      //                                                         'blood_oxygen'],
                      //                                                     style: FlutterFlowTheme.of(context)
                      //                                                         .bodyText1
                      //                                                         .override(
                      //                                                           fontFamily: 'Montserrat',
                      //                                                           color: Color(0xFFE5E5E5),
                      //                                                           fontSize: 20,
                      //                                                           fontWeight: FontWeight.w200,
                      //                                                         ),
                      //                                                   ),
                      //                                                 ],
                      //                                               ),
                      //                                             ],
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                                 Column(
                      //                                   mainAxisSize:
                      //                                       MainAxisSize.max,
                      //                                   mainAxisAlignment:
                      //                                       MainAxisAlignment
                      //                                           .end,
                      //                                   crossAxisAlignment:
                      //                                       CrossAxisAlignment
                      //                                           .end,
                      //                                   children: [
                      //                                     Row(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .spaceBetween,
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       20,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Icon(
                      //                                             Icons
                      //                                                 .arrow_forward_ios_sharp,
                      //                                             color: Color(
                      //                                                 0xFF00B89F),
                      //                                             size: 35,
                      //                                           ),
                      //                                         ),
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       1,
                      //                                                       0,
                      //                                                       0),
                      //                                           child:
                      //                                               Image.asset(
                      //                                             'assets/images/pulse-oximeter.png',
                      //                                             height: 90,
                      //                                             fit: BoxFit
                      //                                                 .fill,
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsetsDirectional.fromSTEB(
                      //                     10, 0, 10, 10),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceAround,
                      //                   children: [
                      //                     Expanded(
                      //                       child: Container(
                      //                         decoration: BoxDecoration(
                      //                           color: Color(0xFF272E36),
                      //                           borderRadius:
                      //                               BorderRadius.circular(10),
                      //                         ),
                      //                         child: InkWell(
                      //                           onTap: () async {
                      //                             await Navigator.push(
                      //                               context,
                      //                               MaterialPageRoute(
                      //                                 builder: (context) =>
                      //                                     SleepWidget(),
                      //                               ),
                      //                             );
                      //                           },
                      //                           child: Column(
                      //                             mainAxisSize:
                      //                                 MainAxisSize.max,
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment.end,
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               Stack(
                      //                                 children: [
                      //                                   Padding(
                      //                                     padding:
                      //                                         EdgeInsetsDirectional
                      //                                             .fromSTEB(15,
                      //                                                 0, 50, 0),
                      //                                     child: Column(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment
                      //                                               .start,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       10,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Row(
                      //                                             mainAxisSize:
                      //                                                 MainAxisSize
                      //                                                     .max,
                      //                                             children: [
                      //                                               Text(
                      //                                                 'Sleep',
                      //                                                 style: FlutterFlowTheme.of(
                      //                                                         context)
                      //                                                     .bodyText1
                      //                                                     .override(
                      //                                                       fontFamily:
                      //                                                           'Montserrat',
                      //                                                       color:
                      //                                                           Color(0xFF00B89F),
                      //                                                       fontSize:
                      //                                                           10,
                      //                                                       fontWeight:
                      //                                                           FontWeight.w300,
                      //                                                     ),
                      //                                               ),
                      //                                             ],
                      //                                           ),
                      //                                         ),
                      //                                         Row(
                      //                                           mainAxisSize:
                      //                                               MainAxisSize
                      //                                                   .max,
                      //                                           children: [
                      //                                             Text(
                      //                                               info["watch_status"]
                      //                                                   [
                      //                                                   'sleep'],
                      //                                               style: FlutterFlowTheme.of(
                      //                                                       context)
                      //                                                   .bodyText1
                      //                                                   .override(
                      //                                                     fontFamily:
                      //                                                         'Montserrat',
                      //                                                     color:
                      //                                                         Color(0xFFE5E5E5),
                      //                                                     fontSize:
                      //                                                         20,
                      //                                                     fontWeight:
                      //                                                         FontWeight.w200,
                      //                                                   ),
                      //                                             ),
                      //                                           ],
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               Column(
                      //                                 mainAxisSize:
                      //                                     MainAxisSize.max,
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment.end,
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .end,
                      //                                 children: [
                      //                                   Row(
                      //                                     mainAxisSize:
                      //                                         MainAxisSize.max,
                      //                                     mainAxisAlignment:
                      //                                         MainAxisAlignment
                      //                                             .spaceBetween,
                      //                                     crossAxisAlignment:
                      //                                         CrossAxisAlignment
                      //                                             .center,
                      //                                     children: [
                      //                                       Padding(
                      //                                         padding:
                      //                                             EdgeInsetsDirectional
                      //                                                 .fromSTEB(
                      //                                                     0,
                      //                                                     20,
                      //                                                     0,
                      //                                                     0),
                      //                                         child: Icon(
                      //                                           Icons
                      //                                               .arrow_forward_ios_sharp,
                      //                                           color: Color(
                      //                                               0xFF00B89F),
                      //                                           size: 35,
                      //                                         ),
                      //                                       ),
                      //                                       Padding(
                      //                                         padding:
                      //                                             EdgeInsetsDirectional
                      //                                                 .fromSTEB(
                      //                                                     0,
                      //                                                     1,
                      //                                                     0,
                      //                                                     0),
                      //                                         child:
                      //                                             Image.asset(
                      //                                           'assets/images/Layer_2_active.png',
                      //                                           height: 90,
                      //                                           fit:
                      //                                               BoxFit.fill,
                      //                                         ),
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       child: Padding(
                      //                         padding: EdgeInsetsDirectional
                      //                             .fromSTEB(10, 0, 0, 0),
                      //                         child: Container(
                      //                           decoration: BoxDecoration(
                      //                             color: Color(0xFF272E36),
                      //                             borderRadius:
                      //                                 BorderRadius.circular(10),
                      //                           ),
                      //                           child: InkWell(
                      //                             onTap: () async {
                      //                               await Navigator.push(
                      //                                 context,
                      //                                 MaterialPageRoute(
                      //                                   builder: (context) =>
                      //                                       StepWidget(
                      //                                           data:
                      //                                               selectedId),
                      //                                 ),
                      //                               );
                      //                             },
                      //                             child: Column(
                      //                               mainAxisSize:
                      //                                   MainAxisSize.max,
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment.end,
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                               children: [
                      //                                 Stack(
                      //                                   children: [
                      //                                     Row(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       15,
                      //                                                       0,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Column(
                      //                                             mainAxisSize:
                      //                                                 MainAxisSize
                      //                                                     .max,
                      //                                             crossAxisAlignment:
                      //                                                 CrossAxisAlignment
                      //                                                     .start,
                      //                                             children: [
                      //                                               Padding(
                      //                                                 padding: EdgeInsetsDirectional
                      //                                                     .fromSTEB(
                      //                                                         0,
                      //                                                         10,
                      //                                                         0,
                      //                                                         0),
                      //                                                 child:
                      //                                                     Row(
                      //                                                   mainAxisSize:
                      //                                                       MainAxisSize.max,
                      //                                                   children: [
                      //                                                     Text(
                      //                                                       'Steps',
                      //                                                       style: FlutterFlowTheme.of(context).bodyText1.override(
                      //                                                             fontFamily: 'Montserrat',
                      //                                                             color: Color(0xFF00B89F),
                      //                                                             fontSize: 10,
                      //                                                             fontWeight: FontWeight.w300,
                      //                                                           ),
                      //                                                     ),
                      //                                                   ],
                      //                                                 ),
                      //                                               ),
                      //                                               Row(
                      //                                                 mainAxisSize:
                      //                                                     MainAxisSize
                      //                                                         .max,
                      //                                                 children: [
                      //                                                   Text(
                      //                                                     info["watch_status"]
                      //                                                         [
                      //                                                         'step'],
                      //                                                     style: FlutterFlowTheme.of(context)
                      //                                                         .bodyText1
                      //                                                         .override(
                      //                                                           fontFamily: 'Montserrat',
                      //                                                           color: Color(0xFFE5E5E5),
                      //                                                           fontSize: 20,
                      //                                                           fontWeight: FontWeight.w200,
                      //                                                         ),
                      //                                                   ),
                      //                                                 ],
                      //                                               ),
                      //                                             ],
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                                 Column(
                      //                                   mainAxisSize:
                      //                                       MainAxisSize.max,
                      //                                   mainAxisAlignment:
                      //                                       MainAxisAlignment
                      //                                           .end,
                      //                                   crossAxisAlignment:
                      //                                       CrossAxisAlignment
                      //                                           .end,
                      //                                   children: [
                      //                                     Row(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .spaceBetween,
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       20,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Icon(
                      //                                             Icons
                      //                                                 .arrow_forward_ios_sharp,
                      //                                             color: Color(
                      //                                                 0xFF00B89F),
                      //                                             size: 35,
                      //                                           ),
                      //                                         ),
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       1,
                      //                                                       0,
                      //                                                       0),
                      //                                           child:
                      //                                               Image.asset(
                      //                                             'assets/images/8679613_footprint_line_icon_active.png',
                      //                                             height: 90,
                      //                                             fit: BoxFit
                      //                                                 .fill,
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsetsDirectional.fromSTEB(
                      //                     10, 0, 10, 10),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceAround,
                      //                   children: [
                      //                     Expanded(
                      //                       child: Container(
                      //                         decoration: BoxDecoration(
                      //                           color: Color(0xFF272E36),
                      //                           borderRadius:
                      //                               BorderRadius.circular(10),
                      //                         ),
                      //                         child: InkWell(
                      //                           onTap: () async {
                      //                             await Navigator.push(
                      //                               context,
                      //                               MaterialPageRoute(
                      //                                 builder: (context) =>
                      //                                     CalorieWidget(
                      //                                         data: selectedId),
                      //                               ),
                      //                             );
                      //                           },
                      //                           child: Column(
                      //                             mainAxisSize:
                      //                                 MainAxisSize.max,
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment.end,
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               Stack(
                      //                                 children: [
                      //                                   Padding(
                      //                                     padding:
                      //                                         EdgeInsetsDirectional
                      //                                             .fromSTEB(15,
                      //                                                 0, 50, 0),
                      //                                     child: Column(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment
                      //                                               .start,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       10,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Row(
                      //                                             mainAxisSize:
                      //                                                 MainAxisSize
                      //                                                     .max,
                      //                                             children: [
                      //                                               Text(
                      //                                                 'Calorie\'s',
                      //                                                 style: FlutterFlowTheme.of(
                      //                                                         context)
                      //                                                     .bodyText1
                      //                                                     .override(
                      //                                                       fontFamily:
                      //                                                           'Montserrat',
                      //                                                       color:
                      //                                                           Color(0xFF00B89F),
                      //                                                       fontSize:
                      //                                                           10,
                      //                                                       fontWeight:
                      //                                                           FontWeight.w300,
                      //                                                     ),
                      //                                               ),
                      //                                             ],
                      //                                           ),
                      //                                         ),
                      //                                         Row(
                      //                                           mainAxisSize:
                      //                                               MainAxisSize
                      //                                                   .max,
                      //                                           children: [
                      //                                             Text(
                      //                                               info["watch_status"]
                      //                                                   [
                      //                                                   "calories"],
                      //                                               style: FlutterFlowTheme.of(
                      //                                                       context)
                      //                                                   .bodyText1
                      //                                                   .override(
                      //                                                     fontFamily:
                      //                                                         'Montserrat',
                      //                                                     color:
                      //                                                         Color(0xFFE5E5E5),
                      //                                                     fontSize:
                      //                                                         20,
                      //                                                     fontWeight:
                      //                                                         FontWeight.w200,
                      //                                                   ),
                      //                                             ),
                      //                                           ],
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               Column(
                      //                                 mainAxisSize:
                      //                                     MainAxisSize.max,
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment.end,
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .end,
                      //                                 children: [
                      //                                   Row(
                      //                                     mainAxisSize:
                      //                                         MainAxisSize.max,
                      //                                     mainAxisAlignment:
                      //                                         MainAxisAlignment
                      //                                             .spaceBetween,
                      //                                     crossAxisAlignment:
                      //                                         CrossAxisAlignment
                      //                                             .center,
                      //                                     children: [
                      //                                       Padding(
                      //                                         padding:
                      //                                             EdgeInsetsDirectional
                      //                                                 .fromSTEB(
                      //                                                     0,
                      //                                                     20,
                      //                                                     0,
                      //                                                     0),
                      //                                         child: Icon(
                      //                                           Icons
                      //                                               .arrow_forward_ios_sharp,
                      //                                           color: Color(
                      //                                               0xFF00B89F),
                      //                                           size: 35,
                      //                                         ),
                      //                                       ),
                      //                                       Padding(
                      //                                         padding:
                      //                                             EdgeInsetsDirectional
                      //                                                 .fromSTEB(
                      //                                                     0,
                      //                                                     1,
                      //                                                     0,
                      //                                                     0),
                      //                                         child:
                      //                                             Image.asset(
                      //                                           'assets/images/Group 697.png',
                      //                                           height: 90,
                      //                                           fit:
                      //                                               BoxFit.fill,
                      //                                         ),
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       child: Padding(
                      //                         padding: EdgeInsetsDirectional
                      //                             .fromSTEB(10, 0, 0, 0),
                      //                         child: Container(
                      //                           decoration: BoxDecoration(
                      //                             color: Color(0xFF272E36),
                      //                             borderRadius:
                      //                                 BorderRadius.circular(10),
                      //                           ),
                      //                           child: InkWell(
                      //                             onTap: () async {
                      //                               await Navigator.push(
                      //                                 context,
                      //                                 MaterialPageRoute(
                      //                                   builder: (context) =>
                      //                                       BloodWidget(),
                      //                                 ),
                      //                               );
                      //                             },
                      //                             child: Column(
                      //                               mainAxisSize:
                      //                                   MainAxisSize.max,
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment.end,
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                               children: [
                      //                                 Stack(
                      //                                   children: [
                      //                                     Row(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       15,
                      //                                                       0,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Column(
                      //                                             mainAxisSize:
                      //                                                 MainAxisSize
                      //                                                     .max,
                      //                                             crossAxisAlignment:
                      //                                                 CrossAxisAlignment
                      //                                                     .start,
                      //                                             children: [
                      //                                               Padding(
                      //                                                 padding: EdgeInsetsDirectional
                      //                                                     .fromSTEB(
                      //                                                         0,
                      //                                                         10,
                      //                                                         0,
                      //                                                         0),
                      //                                                 child:
                      //                                                     Row(
                      //                                                   mainAxisSize:
                      //                                                       MainAxisSize.max,
                      //                                                   children: [
                      //                                                     Text(
                      //                                                       'Blood Pressure',
                      //                                                       style: FlutterFlowTheme.of(context).bodyText1.override(
                      //                                                             fontFamily: 'Montserrat',
                      //                                                             color: Color(0xFF00B89F),
                      //                                                             fontSize: 10,
                      //                                                             fontWeight: FontWeight.w300,
                      //                                                           ),
                      //                                                     ),
                      //                                                   ],
                      //                                                 ),
                      //                                               ),
                      //                                               Row(
                      //                                                 mainAxisSize:
                      //                                                     MainAxisSize
                      //                                                         .max,
                      //                                                 children: [
                      //                                                   Text(
                      //                                                     "sys: " +
                      //                                                         info["watch_status"]["blood_pressure"]["sys"],
                      //                                                     style: FlutterFlowTheme.of(context)
                      //                                                         .bodyText1
                      //                                                         .override(
                      //                                                           fontFamily: 'Montserrat',
                      //                                                           color: Color(0xFFE5E5E5),
                      //                                                           fontSize: 11,
                      //                                                           fontWeight: FontWeight.w200,
                      //                                                         ),
                      //                                                   ),
                      //                                                 ],
                      //                                               ),
                      //                                               Row(
                      //                                                 mainAxisSize:
                      //                                                     MainAxisSize
                      //                                                         .max,
                      //                                                 children: [
                      //                                                   Text(
                      //                                                     "dia: " +
                      //                                                         info["watch_status"]["blood_pressure"]["dia"],
                      //                                                     style: FlutterFlowTheme.of(context)
                      //                                                         .bodyText1
                      //                                                         .override(
                      //                                                           fontFamily: 'Montserrat',
                      //                                                           color: Color(0xFFE5E5E5),
                      //                                                           fontSize: 11,
                      //                                                           fontWeight: FontWeight.w200,
                      //                                                         ),
                      //                                                   ),
                      //                                                 ],
                      //                                               ),
                      //                                             ],
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                                 Column(
                      //                                   mainAxisSize:
                      //                                       MainAxisSize.max,
                      //                                   mainAxisAlignment:
                      //                                       MainAxisAlignment
                      //                                           .end,
                      //                                   crossAxisAlignment:
                      //                                       CrossAxisAlignment
                      //                                           .end,
                      //                                   children: [
                      //                                     Row(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .spaceBetween,
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       20,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Icon(
                      //                                             Icons
                      //                                                 .arrow_forward_ios_sharp,
                      //                                             color: Color(
                      //                                                 0xFF00B89F),
                      //                                             size: 35,
                      //                                           ),
                      //                                         ),
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       1,
                      //                                                       0,
                      //                                                       0),
                      //                                           child:
                      //                                               Image.asset(
                      //                                             'assets/images/01.png',
                      //                                             height: 90,
                      //                                             fit: BoxFit
                      //                                                 .fill,
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsetsDirectional.fromSTEB(
                      //                     10, 0, 10, 10),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceAround,
                      //                   children: [
                      //                     Expanded(
                      //                       child: Container(
                      //                         decoration: BoxDecoration(
                      //                           color: Color(0xFF272E36),
                      //                           borderRadius:
                      //                               BorderRadius.circular(10),
                      //                         ),
                      //                         child: InkWell(
                      //                           onTap: () async {
                      //                             await Navigator.push(
                      //                               context,
                      //                               MaterialPageRoute(
                      //                                 builder: (context) =>
                      //                                     BatteryWidget(),
                      //                               ),
                      //                             );
                      //                           },
                      //                           child: Column(
                      //                             mainAxisSize:
                      //                                 MainAxisSize.max,
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment.end,
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               Stack(
                      //                                 children: [
                      //                                   Padding(
                      //                                     padding:
                      //                                         EdgeInsetsDirectional
                      //                                             .fromSTEB(15,
                      //                                                 0, 50, 0),
                      //                                     child: Column(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment
                      //                                               .start,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       10,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Row(
                      //                                             mainAxisSize:
                      //                                                 MainAxisSize
                      //                                                     .max,
                      //                                             children: [
                      //                                               Text(
                      //                                                 'Smart Watch Battery',
                      //                                                 style: FlutterFlowTheme.of(
                      //                                                         context)
                      //                                                     .bodyText1
                      //                                                     .override(
                      //                                                       fontFamily:
                      //                                                           'Montserrat',
                      //                                                       color:
                      //                                                           Color(0xFF00B89F),
                      //                                                       fontSize:
                      //                                                           10,
                      //                                                       fontWeight:
                      //                                                           FontWeight.w300,
                      //                                                     ),
                      //                                               ),
                      //                                             ],
                      //                                           ),
                      //                                         ),
                      //                                         Row(
                      //                                           mainAxisSize:
                      //                                               MainAxisSize
                      //                                                   .max,
                      //                                           children: [
                      //                                             Text(
                      //                                               info["watch_status"]
                      //                                                   [
                      //                                                   "battery_level"],
                      //                                               style: FlutterFlowTheme.of(
                      //                                                       context)
                      //                                                   .bodyText1
                      //                                                   .override(
                      //                                                     fontFamily:
                      //                                                         'Montserrat',
                      //                                                     color:
                      //                                                         Color(0xFFE5E5E5),
                      //                                                     fontSize:
                      //                                                         20,
                      //                                                     fontWeight:
                      //                                                         FontWeight.w200,
                      //                                                   ),
                      //                                             ),
                      //                                           ],
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               Column(
                      //                                 mainAxisSize:
                      //                                     MainAxisSize.max,
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment.end,
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .end,
                      //                                 children: [
                      //                                   Row(
                      //                                     mainAxisSize:
                      //                                         MainAxisSize.max,
                      //                                     mainAxisAlignment:
                      //                                         MainAxisAlignment
                      //                                             .spaceBetween,
                      //                                     crossAxisAlignment:
                      //                                         CrossAxisAlignment
                      //                                             .center,
                      //                                     children: [
                      //                                       Padding(
                      //                                         padding:
                      //                                             EdgeInsetsDirectional
                      //                                                 .fromSTEB(
                      //                                                     0,
                      //                                                     20,
                      //                                                     0,
                      //                                                     0),
                      //                                         child: Icon(
                      //                                           Icons
                      //                                               .arrow_forward_ios_sharp,
                      //                                           color: Color(
                      //                                               0xFF00B89F),
                      //                                           size: 35,
                      //                                         ),
                      //                                       ),
                      //                                       Padding(
                      //                                         padding:
                      //                                             EdgeInsetsDirectional
                      //                                                 .fromSTEB(
                      //                                                     0,
                      //                                                     1,
                      //                                                     0,
                      //                                                     0),
                      //                                         child: SvgPicture
                      //                                             .asset(
                      //                                           'assets/images/65-battery (1).svg',
                      //                                           height: 90,
                      //                                           fit:
                      //                                               BoxFit.fill,
                      //                                         ),
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       child: Padding(
                      //                         padding: EdgeInsetsDirectional
                      //                             .fromSTEB(10, 0, 0, 0),
                      //                         child: Container(
                      //                           decoration: BoxDecoration(
                      //                             color: Color(0xFF272E36),
                      //                             borderRadius:
                      //                                 BorderRadius.circular(10),
                      //                           ),
                      //                           child: InkWell(
                      //                             onTap: () async {
                      //                               await Navigator.push(
                      //                                 context,
                      //                                 MaterialPageRoute(
                      //                                   builder: (context) =>
                      //                                       PillWidget(),
                      //                                 ),
                      //                               );
                      //                             },
                      //                             child: Column(
                      //                               mainAxisSize:
                      //                                   MainAxisSize.max,
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment.end,
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                               children: [
                      //                                 Stack(
                      //                                   children: [
                      //                                     Row(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       15,
                      //                                                       0,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Column(
                      //                                             mainAxisSize:
                      //                                                 MainAxisSize
                      //                                                     .max,
                      //                                             crossAxisAlignment:
                      //                                                 CrossAxisAlignment
                      //                                                     .start,
                      //                                             children: [
                      //                                               Padding(
                      //                                                 padding: EdgeInsetsDirectional
                      //                                                     .fromSTEB(
                      //                                                         0,
                      //                                                         10,
                      //                                                         0,
                      //                                                         0),
                      //                                                 child:
                      //                                                     Row(
                      //                                                   mainAxisSize:
                      //                                                       MainAxisSize.max,
                      //                                                   children: [
                      //                                                     Text(
                      //                                                       'Pill Box',
                      //                                                       style: FlutterFlowTheme.of(context).bodyText1.override(
                      //                                                             fontFamily: 'Montserrat',
                      //                                                             color: Color(0xFF00B89F),
                      //                                                             fontSize: 10,
                      //                                                             fontWeight: FontWeight.w300,
                      //                                                           ),
                      //                                                     ),
                      //                                                   ],
                      //                                                 ),
                      //                                               ),
                      //                                               Row(
                      //                                                 mainAxisSize:
                      //                                                     MainAxisSize
                      //                                                         .max,
                      //                                                 children: [
                      //                                                   Text(
                      //                                                     info["sensors_status"]
                      //                                                         [
                      //                                                         "pillbox"],
                      //                                                     style: FlutterFlowTheme.of(context)
                      //                                                         .bodyText1
                      //                                                         .override(
                      //                                                           fontFamily: 'Montserrat',
                      //                                                           color: Color(0xFFE5E5E5),
                      //                                                           fontSize: 20,
                      //                                                           fontWeight: FontWeight.w200,
                      //                                                         ),
                      //                                                   ),
                      //                                                 ],
                      //                                               ),
                      //                                             ],
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                                 Column(
                      //                                   mainAxisSize:
                      //                                       MainAxisSize.max,
                      //                                   mainAxisAlignment:
                      //                                       MainAxisAlignment
                      //                                           .end,
                      //                                   crossAxisAlignment:
                      //                                       CrossAxisAlignment
                      //                                           .end,
                      //                                   children: [
                      //                                     Row(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .spaceBetween,
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       20,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Icon(
                      //                                             Icons
                      //                                                 .arrow_forward_ios_sharp,
                      //                                             color: Color(
                      //                                                 0xFF00B89F),
                      //                                             size: 35,
                      //                                           ),
                      //                                         ),
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       1,
                      //                                                       0,
                      //                                                       0),
                      //                                           child:
                      //                                               Image.asset(
                      //                                             'assets/images/8675105_ic_fluent_pill_regular_icon.png',
                      //                                             height: 90,
                      //                                             fit: BoxFit
                      //                                                 .fill,
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsetsDirectional.fromSTEB(
                      //                     10, 0, 10, 10),
                      //                 child: Row(
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceAround,
                      //                   children: [
                      //                     Expanded(
                      //                       child: Container(
                      //                         decoration: BoxDecoration(
                      //                           color: Color(0xFF272E36),
                      //                           borderRadius:
                      //                               BorderRadius.circular(10),
                      //                         ),
                      //                         child: InkWell(
                      //                           onTap: () async {
                      //                             await Navigator.push(
                      //                               context,
                      //                               MaterialPageRoute(
                      //                                 builder: (context) =>
                      //                                     DoorWidget(),
                      //                               ),
                      //                             );
                      //                           },
                      //                           child: Column(
                      //                             mainAxisSize:
                      //                                 MainAxisSize.max,
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment.end,
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               Stack(
                      //                                 children: [
                      //                                   Padding(
                      //                                     padding:
                      //                                         EdgeInsetsDirectional
                      //                                             .fromSTEB(15,
                      //                                                 0, 50, 0),
                      //                                     child: Column(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment
                      //                                               .start,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       10,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Row(
                      //                                             mainAxisSize:
                      //                                                 MainAxisSize
                      //                                                     .max,
                      //                                             children: [
                      //                                               Text(
                      //                                                 'Door',
                      //                                                 style: FlutterFlowTheme.of(
                      //                                                         context)
                      //                                                     .bodyText1
                      //                                                     .override(
                      //                                                       fontFamily:
                      //                                                           'Montserrat',
                      //                                                       color:
                      //                                                           Color(0xFF00B89F),
                      //                                                       fontSize:
                      //                                                           10,
                      //                                                       fontWeight:
                      //                                                           FontWeight.w300,
                      //                                                     ),
                      //                                               ),
                      //                                             ],
                      //                                           ),
                      //                                         ),
                      //                                         Row(
                      //                                           mainAxisSize:
                      //                                               MainAxisSize
                      //                                                   .max,
                      //                                           children: [
                      //                                             Text(
                      //                                               info["sensors_status"]
                      //                                                   [
                      //                                                   "door"],
                      //                                               style: FlutterFlowTheme.of(
                      //                                                       context)
                      //                                                   .bodyText1
                      //                                                   .override(
                      //                                                     fontFamily:
                      //                                                         'Montserrat',
                      //                                                     color:
                      //                                                         Color(0xFFE5E5E5),
                      //                                                     fontSize:
                      //                                                         20,
                      //                                                     fontWeight:
                      //                                                         FontWeight.w200,
                      //                                                   ),
                      //                                             ),
                      //                                           ],
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               Column(
                      //                                 mainAxisSize:
                      //                                     MainAxisSize.max,
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment.end,
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .end,
                      //                                 children: [
                      //                                   Row(
                      //                                     mainAxisSize:
                      //                                         MainAxisSize.max,
                      //                                     mainAxisAlignment:
                      //                                         MainAxisAlignment
                      //                                             .spaceBetween,
                      //                                     crossAxisAlignment:
                      //                                         CrossAxisAlignment
                      //                                             .center,
                      //                                     children: [
                      //                                       Padding(
                      //                                         padding:
                      //                                             EdgeInsetsDirectional
                      //                                                 .fromSTEB(
                      //                                                     0,
                      //                                                     20,
                      //                                                     0,
                      //                                                     0),
                      //                                         child: Icon(
                      //                                           Icons
                      //                                               .arrow_forward_ios_sharp,
                      //                                           color: Color(
                      //                                               0xFF00B89F),
                      //                                           size: 35,
                      //                                         ),
                      //                                       ),
                      //                                       Padding(
                      //                                         padding:
                      //                                             EdgeInsetsDirectional
                      //                                                 .fromSTEB(
                      //                                                     0,
                      //                                                     1,
                      //                                                     0,
                      //                                                     0),
                      //                                         child:
                      //                                             Image.asset(
                      //                                           'assets/images/7068954_furniture_door_interior_house_front_icon.png',
                      //                                           height: 90,
                      //                                           fit:
                      //                                               BoxFit.fill,
                      //                                         ),
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       child: Padding(
                      //                         padding: EdgeInsetsDirectional
                      //                             .fromSTEB(10, 0, 0, 0),
                      //                         child: Container(
                      //                           decoration: BoxDecoration(
                      //                             color: Color(0xFF272E36),
                      //                             borderRadius:
                      //                                 BorderRadius.circular(10),
                      //                           ),
                      //                           child: InkWell(
                      //                             onTap: () async {
                      //                               await Navigator.push(
                      //                                 context,
                      //                                 MaterialPageRoute(
                      //                                   builder: (context) =>
                      //                                       ShowerWidget(),
                      //                                 ),
                      //                               );
                      //                             },
                      //                             child: Column(
                      //                               mainAxisSize:
                      //                                   MainAxisSize.max,
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment.end,
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                               children: [
                      //                                 Stack(
                      //                                   children: [
                      //                                     Row(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       15,
                      //                                                       0,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Column(
                      //                                             mainAxisSize:
                      //                                                 MainAxisSize
                      //                                                     .max,
                      //                                             crossAxisAlignment:
                      //                                                 CrossAxisAlignment
                      //                                                     .start,
                      //                                             children: [
                      //                                               Padding(
                      //                                                 padding: EdgeInsetsDirectional
                      //                                                     .fromSTEB(
                      //                                                         0,
                      //                                                         10,
                      //                                                         0,
                      //                                                         0),
                      //                                                 child:
                      //                                                     Row(
                      //                                                   mainAxisSize:
                      //                                                       MainAxisSize.max,
                      //                                                   children: [
                      //                                                     Text(
                      //                                                       'Shower',
                      //                                                       style: FlutterFlowTheme.of(context).bodyText1.override(
                      //                                                             fontFamily: 'Montserrat',
                      //                                                             color: Color(0xFF00B89F),
                      //                                                             fontSize: 10,
                      //                                                             fontWeight: FontWeight.w300,
                      //                                                           ),
                      //                                                     ),
                      //                                                   ],
                      //                                                 ),
                      //                                               ),
                      //                                               Row(
                      //                                                 mainAxisSize:
                      //                                                     MainAxisSize
                      //                                                         .max,
                      //                                                 children: [
                      //                                                   Text(
                      //                                                     info["sensors_status"]
                      //                                                         [
                      //                                                         "shower"],
                      //                                                     style: FlutterFlowTheme.of(context)
                      //                                                         .bodyText1
                      //                                                         .override(
                      //                                                           fontFamily: 'Montserrat',
                      //                                                           color: Color(0xFFE5E5E5),
                      //                                                           fontSize: 20,
                      //                                                           fontWeight: FontWeight.w200,
                      //                                                         ),
                      //                                                   ),
                      //                                                 ],
                      //                                               ),
                      //                                             ],
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                                 Column(
                      //                                   mainAxisSize:
                      //                                       MainAxisSize.max,
                      //                                   mainAxisAlignment:
                      //                                       MainAxisAlignment
                      //                                           .end,
                      //                                   crossAxisAlignment:
                      //                                       CrossAxisAlignment
                      //                                           .end,
                      //                                   children: [
                      //                                     Row(
                      //                                       mainAxisSize:
                      //                                           MainAxisSize
                      //                                               .max,
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .spaceBetween,
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       20,
                      //                                                       0,
                      //                                                       0),
                      //                                           child: Icon(
                      //                                             Icons
                      //                                                 .arrow_forward_ios_sharp,
                      //                                             color: Color(
                      //                                                 0xFF00B89F),
                      //                                             size: 35,
                      //                                           ),
                      //                                         ),
                      //                                         Padding(
                      //                                           padding:
                      //                                               EdgeInsetsDirectional
                      //                                                   .fromSTEB(
                      //                                                       0,
                      //                                                       1,
                      //                                                       0,
                      //                                                       0),
                      //                                           child:
                      //                                               Image.asset(
                      //                                             'assets/images/4944894_bath_bathroom_interiors_pedestal_tub_icon.png',
                      //                                             height: 90,
                      //                                             fit: BoxFit
                      //                                                 .fill,
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         );
                      //       }),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (FFAppState().Chattoggle2 ?? true)
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
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
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.31, -0.83),
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFEEEEEE),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '5',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Color(
                                                                0xFF00B89F),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future fetchSList() async {
    final ApiCallResponse SList = await SeniorsList.call();

    print(SList.jsonBody["seniors"]);
    return SList.jsonBody["seniors"];
  }

  Future fetchDashData(dynamic id) async {
    print(id);
    final ApiCallResponse Ddata = await DashBoardStat.call(id: id);
    // print(Ddata.statusCode);
    print(Ddata.jsonBody["dashboard"]);
    //  return Ddata.jsonBody["dashboard"];
    data = Ddata.jsonBody["dashboard"];

    FFAppState().heart_rate = data["watch_status"]["heart_rate"];
    FFAppState().blood_oxygen = data["watch_status"]["blood_oxygen"];
    FFAppState().Sleep = data["watch_status"]["sleep"];
    FFAppState().Steps = data["watch_status"]["step"];
    FFAppState().Calories = data["watch_status"]["calories"];
    FFAppState().blood_dia = data["watch_status"]["blood_pressure"]["dia"];
    FFAppState().blood_sys = data["watch_status"]["blood_pressure"]["sys"];
    FFAppState().battery_level = data["watch_status"]["battery_level"];
    FFAppState().Pill_box = data["sensors_status"]["sos"]["bool"];
    FFAppState().door = data["sensors_status"]["door"]["bool"];
    FFAppState().shower = data["sensors_status"]["bath"]["bool"];
    print(FFAppState().door);
    // return data;
  }
}

class dashboard extends StatefulWidget {
  const dashboard({Key key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF272E36),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatsWidget(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 0, 50, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Heart Rate',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF00B89F),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          // FFAppState().heart_rate,
                                          FFAppState().heart_rate != "rate"
                                              ? FFAppState().heart_rate + " BPM"
                                              : "0 BPM",
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFFE5E5E5),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w200,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Color(0xFF00B89F),
                                      size: 35,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 1, 0, 0),
                                    child: Image.asset(
                                      'assets/images/15-health.png',
                                      height: 90,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF272E36),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OxygenWidget(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Blood Oxygen',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF00B89F),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                FFAppState().blood_oxygen !=
                                                        "oxygen"
                                                    ? FFAppState().blood_oxygen
                                                    : "0",
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFE5E5E5),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: Color(0xFF00B89F),
                                        size: 35,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 1, 0, 0),
                                      child: Image.asset(
                                        'assets/images/pulse-oximeter.png',
                                        height: 90,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF272E36),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SleepWidget(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 0, 50, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Sleep',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF00B89F),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          FFAppState().Sleep != "sleep"
                                              ? FFAppState().Sleep
                                              : "0",
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFFE5E5E5),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w200,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Color(0xFF00B89F),
                                      size: 35,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 1, 0, 0),
                                    child: Image.asset(
                                      'assets/images/Layer_2_active.png',
                                      height: 90,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF272E36),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StepWidget(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Steps',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF00B89F),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                FFAppState().Steps != "step"
                                                    ? FFAppState().Steps
                                                    : "0",
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFE5E5E5),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: Color(0xFF00B89F),
                                        size: 35,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 1, 0, 0),
                                      child: Image.asset(
                                        'assets/images/8679613_footprint_line_icon_active.png',
                                        height: 90,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF272E36),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalorieWidget(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 0, 50, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Calorie\'s',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF00B89F),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          FFAppState().Calories != "calorie"
                                              ? FFAppState().Calories
                                              : "0",
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFFE5E5E5),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w200,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Color(0xFF00B89F),
                                      size: 35,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 1, 0, 0),
                                    child: Image.asset(
                                      'assets/images/Group 697.png',
                                      height: 90,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF272E36),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BloodWidget(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Blood Pressure',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF00B89F),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                "SYS: " +
                                                    (FFAppState().blood_sys !=
                                                            "sys"
                                                        ? FFAppState().blood_sys
                                                        : "0"),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFE5E5E5),
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                "DIA: " +
                                                    (FFAppState().blood_dia !=
                                                            "dia"
                                                        ? FFAppState().blood_dia
                                                        : "0"),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFE5E5E5),
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: Color(0xFF00B89F),
                                        size: 35,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 1, 0, 0),
                                      child: Image.asset(
                                        'assets/images/01.png',
                                        height: 90,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF272E36),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BatteryWidget(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 0, 50, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Smart Watch Battery',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF00B89F),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          FFAppState().battery_level !=
                                                  "battery"
                                              ? FFAppState().battery_level
                                              : "0",
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFFE5E5E5),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w200,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Color(0xFF00B89F),
                                      size: 35,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 1, 0, 0),
                                    child: SvgPicture.asset(
                                      'assets/images/65-battery (1).svg',
                                      height: 90,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF272E36),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PillWidget(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Pill Box',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF00B89F),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                FFAppState()
                                                    .Pill_box
                                                    .toString(),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFE5E5E5),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: Color(0xFF00B89F),
                                        size: 35,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 1, 0, 0),
                                      child: Image.asset(
                                        'assets/images/8675105_ic_fluent_pill_regular_icon.png',
                                        height: 90,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF272E36),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoorWidget(),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 0, 50, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Door',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF00B89F),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          FFAppState().door.toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFFE5E5E5),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w200,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Color(0xFF00B89F),
                                      size: 35,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 1, 0, 0),
                                    child: Image.asset(
                                      'assets/images/7068954_furniture_door_interior_house_front_icon.png',
                                      height: 90,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF272E36),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowerWidget(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Shower',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF00B89F),
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                FFAppState()
                                                            .shower
                                                            .toString() !=
                                                        true
                                                    ? "Not Bathed"
                                                    : "Bathed",
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFE5E5E5),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: Color(0xFF00B89F),
                                        size: 35,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 1, 0, 0),
                                      child: Image.asset(
                                        'assets/images/4944894_bath_bathroom_interiors_pedestal_tub_icon.png',
                                        height: 90,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
        ],
      ),
    );
  }
}
