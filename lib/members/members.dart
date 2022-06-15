import 'package:n_tel_care_family_app/backend/api_requests/api_calls.dart';
import 'package:n_tel_care_family_app/critical/critical_widget.dart';
import 'package:n_tel_care_family_app/edit/edit_executive.dart';
import 'package:n_tel_care_family_app/edit/edit_member.dart';
import 'package:n_tel_care_family_app/new_user/add.dart';

import '../chat/chat_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MembersWidget extends StatefulWidget {
  const MembersWidget({Key key}) : super(key: key);

  @override
  _MembersWidgetState createState() => _MembersWidgetState();
}

class _MembersWidgetState extends State<MembersWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<dynamic> MList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MList = fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
                          child: Text(
                            'Users',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFFAFAFAF),
                                      fontSize: 40,
                                      fontWeight: FontWeight.w200,
                                    ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Add(),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    color: Color(0xFF00B89F),
                                    size: 30,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: InkWell(
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
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.05, -0.43),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
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
                                                    style: FlutterFlowTheme.of(
                                                            context)
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF1F252B),
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF1F252B),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/171/600',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Julie Paul',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF00B89F),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 0, 0),
                                            child: Text(
                                              'Age 60, Female',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFFE5E5E5),
                                                    fontSize: 12,
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 6, 0, 0),
                                            child: Text(
                                              'More Info',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFFE5E5E5),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF1F252B),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/171/600',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Julie Paul',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF00B89F),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 0, 0),
                                            child: Text(
                                              'Age 60, Female',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFFE5E5E5),
                                                    fontSize: 12,
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 6, 0, 0),
                                            child: Text(
                                              'More Info',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFFE5E5E5),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF1F252B),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    'https://picsum.photos/seed/171/600',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Julie Paul',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF00B89F),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 2, 0, 0),
                                            child: Text(
                                              'Age 60, Female',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFFE5E5E5),
                                                    fontSize: 12,
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 6, 0, 0),
                                            child: Text(
                                              'More Info',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFFE5E5E5),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFF1F252B),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1F252B),
                                  ),
                                  child: DefaultTabController(
                                    length: 2,
                                    initialIndex: 1,
                                    // child: FutureBuilder<dynamic>(
                                    //     future: MList,
                                    //     builder: (context, snapshot) {
                                    //       if (!snapshot.hasData) {
                                    //         return Text(
                                    //           "Loading",
                                    //           style:
                                    //               FlutterFlowTheme.of(context)
                                    //                   .bodyText1
                                    //                   .override(
                                    //                       fontFamily: 'Poppins',
                                    //                       color:
                                    //                           Color(0xFFE5E5E5),
                                    //                       fontSize: 20),
                                    //         );
                                    //       } else {
                                    //         return

                                    child: Column(
                                      children: [
                                        TabBar(
                                          labelColor: Color(0xFF00B89F),
                                          unselectedLabelColor:
                                              Color(0xFFAFAFAF),
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                          indicatorColor: Color(0xFF00B89F),
                                          indicatorWeight: 2,
                                          tabs: [
                                            Tab(
                                              text: 'Executive',
                                            ),
                                            Tab(
                                              text: 'Members',
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: TabBarView(
                                            children: [
                                              Stack(
                                                children: [
                                                  // Align(
                                                  //   alignment:
                                                  //       AlignmentDirectional(
                                                  //           0, 0),
                                                  //   child: ListView
                                                  //       .builder(
                                                  //     padding:
                                                  //         EdgeInsets
                                                  //             .zero,
                                                  //     scrollDirection:
                                                  //         Axis.vertical,
                                                  //     itemCount:
                                                  //         snapshot.data
                                                  //             .length,
                                                  //     itemBuilder:
                                                  //         // ignore: missing_return
                                                  //         (BuildContext
                                                  //                 context,
                                                  //             int index) {
                                                  //       if (snapshot.data[
                                                  //                   index]
                                                  //               [
                                                  //               "Executive"] ==
                                                  //           true)
                                                  //           {
                                                  //         return
                                                  //  Padding(
                                                  //   padding: EdgeInsetsDirectional
                                                  //       .fromSTEB(
                                                  //           5,
                                                  //           10,
                                                  //           5,
                                                  //           0),
                                                  //   child:
                                                  //       InkWell(
                                                  //     onTap:
                                                  //         () async {
                                                  //       await Navigator
                                                  //           .push(
                                                  //         context,
                                                  //         MaterialPageRoute(
                                                  //           builder: (context) =>
                                                  //               EditExecutiveWidget(),
                                                  //         ),
                                                  //       );
                                                  //     },
                                                  //     child:
                                                  //         Card(
                                                  //       clipBehavior:
                                                  //           Clip.antiAliasWithSaveLayer,
                                                  //       color: Color(
                                                  //           0xFF272E36),
                                                  //       child:
                                                  //           Padding(
                                                  //         padding: EdgeInsetsDirectional.fromSTEB(
                                                  //             3,
                                                  //             0,
                                                  //             0,
                                                  //             0),
                                                  //         child:
                                                  //             Row(
                                                  //           mainAxisSize:
                                                  //               MainAxisSize.max,
                                                  //           children: [
                                                  //             Container(
                                                  //               width: 80,
                                                  //               height: 80,
                                                  //               decoration: BoxDecoration(
                                                  //                 color: Color(0xFF272E36),
                                                  //               ),
                                                  //               child: Stack(
                                                  //                 children: [
                                                  //                   Container(
                                                  //                     width: 100,
                                                  //                     height: 100,
                                                  //                     clipBehavior: Clip.antiAlias,
                                                  //                     decoration: BoxDecoration(
                                                  //                       shape: BoxShape.circle,
                                                  //                     ),
                                                  //                     child: Image.network(
                                                  //                       snapshot.data[index]["profile"],
                                                  //                       fit: BoxFit.cover,
                                                  //                     ),
                                                  //                   ),
                                                  //                   Align(
                                                  //                     alignment: AlignmentDirectional(1.2, 0.83),
                                                  //                     child: Container(
                                                  //                       width: 30,
                                                  //                       height: 30,
                                                  //                       decoration: BoxDecoration(
                                                  //                         color: Color(0xFF00B89F),
                                                  //                         shape: BoxShape.circle,
                                                  //                       ),
                                                  //                       alignment: AlignmentDirectional(0, 0),
                                                  //                       child: Column(
                                                  //                         mainAxisSize: MainAxisSize.max,
                                                  //                         mainAxisAlignment: MainAxisAlignment.center,
                                                  //                         children: [
                                                  //                           Expanded(
                                                  //                             child: Column(
                                                  //                               mainAxisSize: MainAxisSize.min,
                                                  //                               mainAxisAlignment: MainAxisAlignment.center,
                                                  //                               crossAxisAlignment: CrossAxisAlignment.center,
                                                  //                               children: [
                                                  //                                 SvgPicture.asset(
                                                  //                                   'assets/images/achievment.svg',
                                                  //                                   height: 20,
                                                  //                                   fit: BoxFit.cover,
                                                  //                                 ),
                                                  //                               ],
                                                  //                             ),
                                                  //                           ),
                                                  //                         ],
                                                  //                       ),
                                                  //                     ),
                                                  //                   ),
                                                  //                 ],
                                                  //               ),
                                                  //             ),
                                                  //             Expanded(
                                                  //               child: Row(
                                                  //                 mainAxisSize: MainAxisSize.max,
                                                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                                                  //                 children: [
                                                  //                   Padding(
                                                  //                     padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                  //                     child: Column(
                                                  //                       mainAxisSize: MainAxisSize.max,
                                                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                                                  //                       children: [
                                                  //                         Row(
                                                  //                           mainAxisSize: MainAxisSize.max,
                                                  //                           children: [
                                                  //                             Text(
                                                  //                               snapshot.data[index]["fname"] + " " + snapshot.data[index]["lname"],
                                                  //                               style: FlutterFlowTheme.of(context).bodyText1.override(
                                                  //                                     fontFamily: 'Montserrat',
                                                  //                                     color: Color(0xFF00B89F),
                                                  //                                     fontWeight: FontWeight.bold,
                                                  //                                   ),
                                                  //                             ),
                                                  //                           ],
                                                  //                         ),
                                                  //                         Row(
                                                  //                           mainAxisSize: MainAxisSize.max,
                                                  //                           children: [
                                                  //                             Text(
                                                  //                               snapshot.data[index]["email"],
                                                  //                               style: FlutterFlowTheme.of(context).bodyText1.override(
                                                  //                                     fontFamily: 'Montserrat',
                                                  //                                     color: Color(0xFFAFAFAF),
                                                  //                                     fontSize: 12,
                                                  //                                     fontWeight: FontWeight.w200,
                                                  //                                   ),
                                                  //                             ),
                                                  //                           ],
                                                  //                         ),
                                                  //                         Row(
                                                  //                           mainAxisSize: MainAxisSize.max,
                                                  //                           children: [
                                                  //                             Text(
                                                  //                               snapshot.data[index]["phone"],
                                                  //                               style: FlutterFlowTheme.of(context).bodyText1.override(
                                                  //                                     fontFamily: 'Montserrat',
                                                  //                                     color: Color(0xFFAFAFAF),
                                                  //                                     fontSize: 12,
                                                  //                                     fontWeight: FontWeight.w200,
                                                  //                                   ),
                                                  //                             ),
                                                  //                           ],
                                                  //                         ),
                                                  //                       ],
                                                  //                     ),
                                                  //                   ),
                                                  //                   Icon(
                                                  //                     Icons.chevron_right,
                                                  //                     color: Color(0xFF00B89F),
                                                  //                     size: 30,
                                                  //                   ),
                                                  //                 ],
                                                  //               ),
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // );
                                                  // }
                                                  Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: ListView(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          10,
                                                                          5,
                                                                          0),
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  await Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              EditExecutiveWidget(),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Card(
                                                                  clipBehavior:
                                                                      Clip.antiAliasWithSaveLayer,
                                                                  color: Color(
                                                                      0xFF272E36),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            3,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              80,
                                                                          height:
                                                                              80,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xFF272E36),
                                                                          ),
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              Container(
                                                                                width: 100,
                                                                                height: 100,
                                                                                clipBehavior: Clip.antiAlias,
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Image.network(
                                                                                  'https://picsum.photos/seed/44/600',
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: AlignmentDirectional(1.2, 0.83),
                                                                                child: Container(
                                                                                  width: 30,
                                                                                  height: 30,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFF00B89F),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                  alignment: AlignmentDirectional(0, 0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: [
                                                                                            SvgPicture.asset(
                                                                                              'assets/images/achievment.svg',
                                                                                              height: 20,
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Ronny',
                                                                                          style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                                fontFamily: 'Montserrat',
                                                                                                color: Color(0xFF00B89F),
                                                                                                fontWeight: FontWeight.bold,
                                                                                              ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Text(
                                                                                          'ronn@gmail.com',
                                                                                          style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                                fontFamily: 'Montserrat',
                                                                                                color: Color(0xFFAFAFAF),
                                                                                                fontSize: 12,
                                                                                                fontWeight: FontWeight.w200,
                                                                                              ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Text(
                                                                                          '+1 654 98 73214',
                                                                                          style: FlutterFlowTheme.of(context).bodyText1.override(
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
                                                                                Icons.chevron_right,
                                                                                color: Color(0xFF00B89F),
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
                                                            )
                                                          ])),
                                                  // Padding(
                                                  //   padding:
                                                  //       EdgeInsetsDirectional
                                                  //           .fromSTEB(
                                                  //               5,
                                                  //               10,
                                                  //               5,
                                                  //               0),
                                                  //   child: InkWell(
                                                  //     onTap:
                                                  //         () async {
                                                  //       await Navigator
                                                  //           .push(
                                                  //         context,
                                                  //         MaterialPageRoute(
                                                  //           builder:
                                                  //               (context) =>
                                                  //                   EditExecutiveWidget(),
                                                  //         ),
                                                  //       );
                                                  //     },
                                                  //     child: Card(
                                                  //       clipBehavior:
                                                  //           Clip.antiAliasWithSaveLayer,
                                                  //       color: Color(
                                                  //           0xFF272E36),
                                                  //       child:
                                                  //           Padding(
                                                  //         padding: EdgeInsetsDirectional
                                                  //             .fromSTEB(
                                                  //                 3,
                                                  //                 0,
                                                  //                 0,
                                                  //                 0),
                                                  //         child:
                                                  //             Row(
                                                  //           mainAxisSize:
                                                  //               MainAxisSize.max,
                                                  //           children: [
                                                  //             Container(
                                                  //               width:
                                                  //                   80,
                                                  //               height:
                                                  //                   80,
                                                  //               decoration:
                                                  //                   BoxDecoration(
                                                  //                 color: Color(0xFF272E36),
                                                  //               ),
                                                  //               child:
                                                  //                   Stack(
                                                  //                 children: [
                                                  //                   Container(
                                                  //                     width: 100,
                                                  //                     height: 100,
                                                  //                     clipBehavior: Clip.antiAlias,
                                                  //                     decoration: BoxDecoration(
                                                  //                       shape: BoxShape.circle,
                                                  //                     ),
                                                  //                     child: Image.network(
                                                  //                       'https://picsum.photos/seed/44/600',
                                                  //                       fit: BoxFit.cover,
                                                  //                     ),
                                                  //                   ),
                                                  //                   Align(
                                                  //                     alignment: AlignmentDirectional(1.2, 0.83),
                                                  //                     child: Container(
                                                  //                       width: 30,
                                                  //                       height: 30,
                                                  //                       decoration: BoxDecoration(
                                                  //                         color: Color(0xFF00B89F),
                                                  //                         shape: BoxShape.circle,
                                                  //                       ),
                                                  //                       alignment: AlignmentDirectional(0, 0),
                                                  //                       child: Column(
                                                  //                         mainAxisSize: MainAxisSize.max,
                                                  //                         mainAxisAlignment: MainAxisAlignment.center,
                                                  //                         children: [
                                                  //                           Expanded(
                                                  //                             child: Column(
                                                  //                               mainAxisSize: MainAxisSize.min,
                                                  //                               mainAxisAlignment: MainAxisAlignment.center,
                                                  //                               crossAxisAlignment: CrossAxisAlignment.center,
                                                  //                               children: [
                                                  //                                 SvgPicture.asset(
                                                  //                                   'assets/images/achievment.svg',
                                                  //                                   height: 20,
                                                  //                                   fit: BoxFit.cover,
                                                  //                                 ),
                                                  //                               ],
                                                  //                             ),
                                                  //                           ),
                                                  //                         ],
                                                  //                       ),
                                                  //                     ),
                                                  //                   ),
                                                  //                 ],
                                                  //               ),
                                                  //             ),
                                                  //             Expanded(
                                                  //               child:
                                                  //                   Row(
                                                  //                 mainAxisSize: MainAxisSize.max,
                                                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                                                  //                 children: [
                                                  //                   Padding(
                                                  //                     padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                  //                     child: Column(
                                                  //                       mainAxisSize: MainAxisSize.max,
                                                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                                                  //                       children: [
                                                  //                         Row(
                                                  //                           mainAxisSize: MainAxisSize.max,
                                                  //                           children: [
                                                  //                             Text(
                                                  //                               'Ronny',
                                                  //                               style: FlutterFlowTheme.of(context).bodyText1.override(
                                                  //                                     fontFamily: 'Montserrat',
                                                  //                                     color: Color(0xFF00B89F),
                                                  //                                     fontWeight: FontWeight.bold,
                                                  //                                   ),
                                                  //                             ),
                                                  //                           ],
                                                  //                         ),
                                                  //                         Row(
                                                  //                           mainAxisSize: MainAxisSize.max,
                                                  //                           children: [
                                                  //                             Text(
                                                  //                               'ronn@gmail.com',
                                                  //                               style: FlutterFlowTheme.of(context).bodyText1.override(
                                                  //                                     fontFamily: 'Montserrat',
                                                  //                                     color: Color(0xFFAFAFAF),
                                                  //                                     fontSize: 12,
                                                  //                                     fontWeight: FontWeight.w200,
                                                  //                                   ),
                                                  //                             ),
                                                  //                           ],
                                                  //                         ),
                                                  //                         Row(
                                                  //                           mainAxisSize: MainAxisSize.max,
                                                  //                           children: [
                                                  //                             Text(
                                                  //                               '+1 654 98 73214',
                                                  //                               style: FlutterFlowTheme.of(context).bodyText1.override(
                                                  //                                     fontFamily: 'Montserrat',
                                                  //                                     color: Color(0xFFAFAFAF),
                                                  //                                     fontSize: 12,
                                                  //                                     fontWeight: FontWeight.w200,
                                                  //                                   ),
                                                  //                             ),
                                                  //                           ],
                                                  //                         ),
                                                  //                       ],
                                                  //                     ),
                                                  //                   ),
                                                  //                   Icon(
                                                  //                     Icons.chevron_right,
                                                  //                     color: Color(0xFF00B89F),
                                                  //                     size: 30,
                                                  //                   ),
                                                  //                 ],
                                                  //               ),
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              // Align(
                                              //   alignment:
                                              //       AlignmentDirectional(
                                              //           0, 0),
                                              //   child: ListView.builder(
                                              //       scrollDirection:
                                              //           Axis.vertical,
                                              //       itemBuilder:
                                              //           // ignore: missing_return
                                              //           (BuildContext
                                              //                   context,
                                              //               int index) {
                                              //         if (snapshot.data[
                                              //                     index]
                                              //                 [
                                              //                 "executive"] ==
                                              //             false) {
                                              //           return
                                              //           Padding(
                                              //             padding: EdgeInsetsDirectional
                                              //                 .fromSTEB(
                                              //                     5,
                                              //                     10,
                                              //                     5,
                                              //                     0),
                                              //             child:
                                              //                 InkWell(
                                              //               onTap:
                                              //                   () async {
                                              //                 await Navigator
                                              //                     .push(
                                              //                   context,
                                              //                   MaterialPageRoute(
                                              //                     builder: (context) =>
                                              //                         EditMemberWidget(),
                                              //                   ),
                                              //                 );
                                              //               },
                                              //               child: Card(
                                              //                 clipBehavior:
                                              //                     Clip.antiAliasWithSaveLayer,
                                              //                 color: Color(
                                              //                     0xFF272E36),
                                              //                 child:
                                              //                     Padding(
                                              //                   padding: EdgeInsetsDirectional.fromSTEB(
                                              //                       3,
                                              //                       0,
                                              //                       0,
                                              //                       0),
                                              //                   child:
                                              //                       Row(
                                              //                     mainAxisSize:
                                              //                         MainAxisSize.max,
                                              //                     children: [
                                              //                       Container(
                                              //                         width: 80,
                                              //                         height: 80,
                                              //                         decoration: BoxDecoration(
                                              //                           color: Color(0xFF272E36),
                                              //                         ),
                                              //                         child: Stack(
                                              //                           children: [
                                              //                             Container(
                                              //                               width: 100,
                                              //                               height: 100,
                                              //                               clipBehavior: Clip.antiAlias,
                                              //                               decoration: BoxDecoration(
                                              //                                 shape: BoxShape.circle,
                                              //                               ),
                                              //                               child: Image.network(
                                              //                                 snapshot.data[index]["profile"],
                                              //                                 fit: BoxFit.cover,
                                              //                               ),
                                              //                             ),
                                              //                           ],
                                              //                         ),
                                              //                       ),
                                              //                       Expanded(
                                              //                         child: Row(
                                              //                           mainAxisSize: MainAxisSize.max,
                                              //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //                           crossAxisAlignment: CrossAxisAlignment.center,
                                              //                           children: [
                                              //                             Padding(
                                              //                               padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                              //                               child: Column(
                                              //                                 mainAxisSize: MainAxisSize.max,
                                              //                                 crossAxisAlignment: CrossAxisAlignment.start,
                                              //                                 children: [
                                              //                                   Row(
                                              //                                     mainAxisSize: MainAxisSize.max,
                                              //                                     children: [
                                              //                                       Text(
                                              //                                         snapshot.data[index]["fname"] + " " + snapshot.data[index]["lname"],
                                              //                                         style: FlutterFlowTheme.of(context).bodyText1.override(
                                              //                                               fontFamily: 'Montserrat',
                                              //                                               color: Color(0xFF00B89F),
                                              //                                               fontWeight: FontWeight.bold,
                                              //                                             ),
                                              //                                       ),
                                              //                                     ],
                                              //                                   ),
                                              //                                   Row(
                                              //                                     mainAxisSize: MainAxisSize.max,
                                              //                                     children: [
                                              //                                       Text(
                                              //                                         snapshot.data[index]["email"],
                                              //                                         style: FlutterFlowTheme.of(context).bodyText1.override(
                                              //                                               fontFamily: 'Montserrat',
                                              //                                               color: Color(0xFFAFAFAF),
                                              //                                               fontSize: 12,
                                              //                                               fontWeight: FontWeight.w200,
                                              //                                             ),
                                              //                                       ),
                                              //                                     ],
                                              //                                   ),
                                              //                                   Row(
                                              //                                     mainAxisSize: MainAxisSize.max,
                                              //                                     children: [
                                              //                                       Text(
                                              //                                         snapshot.data[index]["phone"],
                                              //                                         style: FlutterFlowTheme.of(context).bodyText1.override(
                                              //                                               fontFamily: 'Montserrat',
                                              //                                               color: Color(0xFFAFAFAF),
                                              //                                               fontSize: 12,
                                              //                                               fontWeight: FontWeight.w200,
                                              //                                             ),
                                              //                                       ),
                                              //                                     ],
                                              //                                   ),
                                              //                                 ],
                                              //                               ),
                                              //                             ),
                                              //                             Icon(
                                              //                               Icons.chevron_right,
                                              //                               color: Color(0xFF00B89F),
                                              //                               size: 30,
                                              //                             ),
                                              //                           ],
                                              //                         ),
                                              //                       ),
                                              //                     ],
                                              //                   ),
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //           );
                                              //         }
                                              Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: ListView(
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(5, 10,
                                                                    5, 0),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditMemberWidget(),
                                                              ),
                                                            );
                                                          },
                                                          child: Card(
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            color: Color(
                                                                0xFF272E36),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          3,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: 80,
                                                                    height: 80,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF272E36),
                                                                    ),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              100,
                                                                          height:
                                                                              100,
                                                                          clipBehavior:
                                                                              Clip.antiAlias,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              Image.network(
                                                                            'https://picsum.photos/seed/44/600',
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    'Ronny',
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Montserrat',
                                                                                          color: Color(0xFF00B89F),
                                                                                          fontWeight: FontWeight.bold,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    'ronn@gmail.com',
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                          fontFamily: 'Montserrat',
                                                                                          color: Color(0xFFAFAFAF),
                                                                                          fontSize: 12,
                                                                                          fontWeight: FontWeight.w200,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    '+1 654 98 73214',
                                                                                    style: FlutterFlowTheme.of(context).bodyText1.override(
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
                                                                          color:
                                                                              Color(0xFF00B89F),
                                                                          size:
                                                                              30,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ]
                                                    // Padding(
                                                    //   padding:
                                                    //       EdgeInsetsDirectional
                                                    //           .fromSTEB(
                                                    //               5,
                                                    //               10,
                                                    //               5,
                                                    //               0),
                                                    //   child: InkWell(
                                                    //     onTap: () async {
                                                    //       await Navigator
                                                    //           .push(
                                                    //         context,
                                                    //         MaterialPageRoute(
                                                    //           builder:
                                                    //               (context) =>
                                                    //                   EditMemberWidget(),
                                                    //         ),
                                                    //       );
                                                    //     },
                                                    //     child: Card(
                                                    //       clipBehavior: Clip
                                                    //           .antiAliasWithSaveLayer,
                                                    //       color: Color(
                                                    //           0xFF272E36),
                                                    //       child: Padding(
                                                    //         padding: EdgeInsetsDirectional
                                                    //             .fromSTEB(
                                                    //                 3,
                                                    //                 0,
                                                    //                 0,
                                                    //                 0),
                                                    //         child: Row(
                                                    //           mainAxisSize:
                                                    //               MainAxisSize
                                                    //                   .max,
                                                    //           children: [
                                                    //             Container(
                                                    //               width:
                                                    //                   80,
                                                    //               height:
                                                    //                   80,
                                                    //               decoration:
                                                    //                   BoxDecoration(
                                                    //                 color:
                                                    //                     Color(0xFF272E36),
                                                    //               ),
                                                    //               child:
                                                    //                   Stack(
                                                    //                 children: [
                                                    //                   Container(
                                                    //                     width: 100,
                                                    //                     height: 100,
                                                    //                     clipBehavior: Clip.antiAlias,
                                                    //                     decoration: BoxDecoration(
                                                    //                       shape: BoxShape.circle,
                                                    //                     ),
                                                    //                     child: Image.network(
                                                    //                       'https://picsum.photos/seed/44/600',
                                                    //                       fit: BoxFit.cover,
                                                    //                     ),
                                                    //                   ),
                                                    //                 ],
                                                    //               ),
                                                    //             ),
                                                    //             Expanded(
                                                    //               child:
                                                    //                   Row(
                                                    //                 mainAxisSize:
                                                    //                     MainAxisSize.max,
                                                    //                 mainAxisAlignment:
                                                    //                     MainAxisAlignment.spaceBetween,
                                                    //                 crossAxisAlignment:
                                                    //                     CrossAxisAlignment.center,
                                                    //                 children: [
                                                    //                   Padding(
                                                    //                     padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                    //                     child: Column(
                                                    //                       mainAxisSize: MainAxisSize.max,
                                                    //                       crossAxisAlignment: CrossAxisAlignment.start,
                                                    //                       children: [
                                                    //                         Row(
                                                    //                           mainAxisSize: MainAxisSize.max,
                                                    //                           children: [
                                                    //                             Text(
                                                    //                               'Ronny',
                                                    //                               style: FlutterFlowTheme.of(context).bodyText1.override(
                                                    //                                     fontFamily: 'Montserrat',
                                                    //                                     color: Color(0xFF00B89F),
                                                    //                                     fontWeight: FontWeight.bold,
                                                    //                                   ),
                                                    //                             ),
                                                    //                           ],
                                                    //                         ),
                                                    //                         Row(
                                                    //                           mainAxisSize: MainAxisSize.max,
                                                    //                           children: [
                                                    //                             Text(
                                                    //                               'ronn@gmail.com',
                                                    //                               style: FlutterFlowTheme.of(context).bodyText1.override(
                                                    //                                     fontFamily: 'Montserrat',
                                                    //                                     color: Color(0xFFAFAFAF),
                                                    //                                     fontSize: 12,
                                                    //                                     fontWeight: FontWeight.w200,
                                                    //                                   ),
                                                    //                             ),
                                                    //                           ],
                                                    //                         ),
                                                    //                         Row(
                                                    //                           mainAxisSize: MainAxisSize.max,
                                                    //                           children: [
                                                    //                             Text(
                                                    //                               '+1 654 98 73214',
                                                    //                               style: FlutterFlowTheme.of(context).bodyText1.override(
                                                    //                                     fontFamily: 'Montserrat',
                                                    //                                     color: Color(0xFFAFAFAF),
                                                    //                                     fontSize: 12,
                                                    //                                     fontWeight: FontWeight.w200,
                                                    //                                   ),
                                                    //                             ),
                                                    //                           ],
                                                    //                         ),
                                                    //                       ],
                                                    //                     ),
                                                    //                   ),
                                                    //                   Icon(
                                                    //                     Icons.chevron_right,
                                                    //                     color: Color(0xFF00B89F),
                                                    //                     size: 30,
                                                    //                   ),
                                                    //                 ],
                                                    //               ),
                                                    //             ),
                                                    //           ],
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    //   }
                                    // }),
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
                                          alignment:
                                              AlignmentDirectional(1.31, -0.83),
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFEEEEEE),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '5',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF00B89F),
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
    );
  }

  fetchList() async {
    final ApiCallResponse MList = await MemberList.call();
    print(FFAppState().Token);
    return MList.jsonBody["members"];
  }
}
