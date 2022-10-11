import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:n_tel_care_family_app/backend/ApiService.dart';
import 'package:n_tel_care_family_app/backend/api_requests/api_calls.dart';
import 'package:n_tel_care_family_app/components/custom_toast.dart';
import 'package:n_tel_care_family_app/core/shared_preferences_service.dart';
import 'package:n_tel_care_family_app/critical/critical_widget.dart';
import 'package:n_tel_care_family_app/seniors_list/edit_seniors.dart';
import 'package:n_tel_care_family_app/video/live_stream.dart';
import 'package:n_tel_care_family_app/video/video_player.dart';
import '../chat/chat_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoClipsWidget extends StatefulWidget {
  const VideoClipsWidget({Key key}) : super(key: key);

  @override
  _VideoClipsWidgetState createState() => _VideoClipsWidgetState();
}

class _VideoClipsWidgetState extends State<VideoClipsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<dynamic> SList;
  List<dynamic> _countries;
  int isSelected = 0;
  bool _hasPermissionToViewVideo;
  bool _hasPermissionToViewLiveVideo;
  String rtspLink;

  _isSelected(int index) {
    setState(() {
      isSelected = index;
    });
  }

  Future<void> updateRtspLink(String id) async {
    print("${ApiService.domain}/get/video/$id");
    Response res = await Dio().get("${ApiService.domain}/get/video/$id",
        options: Options(headers: {
          "Authorization":
              "Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}"
        }));
    rtspLink = res.data["data"]["videos"][0][id]["live_video"];
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("RTSP link has been set")));
  }

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
    SList = fetchSList();
    _checkNetworkConnectivity();
    _hasPermissionToViewVideo = FFAppState().viewVideo ?? false;
    _hasPermissionToViewLiveVideo = FFAppState().liveView ?? false;
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
                            'Video Clips',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFFAFAFAF),
                                      fontSize: 40,
                                      fontWeight: FontWeight.w200,
                                    ),
                          ),
                        ),
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
                                // Align(
                                //   alignment: AlignmentDirectional(0.05, -0.43),
                                //   child: Padding(
                                //     padding: EdgeInsetsDirectional.fromSTEB(
                                //         17, 0, 13, 0),
                                //     child: Container(
                                //       width: 15,
                                //       height: 15,
                                //       decoration: BoxDecoration(
                                //         color: Color(0xFF006B5D),
                                //         shape: BoxShape.circle,
                                //       ),
                                //       child: Row(
                                //         mainAxisSize: MainAxisSize.max,
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.center,
                                //         children: [
                                //           Text(
                                //             '5',
                                //             style: FlutterFlowTheme.of(context)
                                //                 .bodyText1
                                //                 .override(
                                //                   fontFamily: 'Montserrat',
                                //                   color: Colors.white,
                                //                   fontSize: 8,
                                //                   fontWeight: FontWeight.bold,
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
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF1F252B),
                    ),
                    child: FutureBuilder<dynamic>(
                        future: SList,
                        builder: (context, snapshot) {
                          final inf = snapshot.data;
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
                            if ((inf as List).length != 0)
                              updateRtspLink(inf[0]["id"]);
                            return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1F252B),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // setState(() {
                                              //   selectedId = id;
                                              // });
                                              _isSelected(index);
                                              updateRtspLink(inf[index]["id"]);
                                            },
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: isSelected == true
                                                    ? Colors.red
                                                    : Colors.black,
                                              ),
                                              child: Image.network(
                                                inf[index]["profile"] ??
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYL2_7f_QDJhq5m9FYGrz5W4QI5EUuDLSdGA&usqp=CAU",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 20, 0, 0),
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
                                                        inf[index]["fname"] +
                                                            " " +
                                                            inf[index]["lname"],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  fontSize: 14,
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
                                                                  0, 2, 0, 0),
                                                      child: Text(
                                                        "Age " +
                                                            inf[index]["age"] +
                                                            ", " +
                                                            inf[index]
                                                                ["gender"],
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  fontSize: 12,
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
                                                                  data: snapshot
                                                                          .data[
                                                                      index],
                                                                  countries:
                                                                      _countries,
                                                                )));
                                                    setState(() {
                                                      SList = fetchSList();
                                                    });
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 6, 0, 0),
                                                        child: Text(
                                                          'More Info',
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
                                                                    ? Colors
                                                                        .blue
                                                                    : Color(
                                                                        0xFF535353),
                                                                fontSize: 12,
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 100),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF1F252B),
                        ),
                        child: DefaultTabController(
                          length: 2,
                          initialIndex: 1,
                          child: Column(
                            children: [
                              TabBar(
                                labelColor: Color(0xFF00B89F),
                                unselectedLabelColor: Color(0xFFAFAFAF),
                                labelStyle: FlutterFlowTheme.of(context)
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
                                    text: 'Live View',
                                  ),
                                  Tab(
                                    text: 'Motion Clips',
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    Stack(
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: _hasPermissionToViewLiveVideo
                                              ? ListView(
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 5, 5, 0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      LiveStreamWidget(
                                                                        rtsp:
                                                                            rtspLink,
                                                                      )));
                                                        },
                                                        child: Card(
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          color:
                                                              Color(0xFF272E36),
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
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child:
                                                                      Container(
                                                                    width: 80,
                                                                    height: 80,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xFF262626),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                    ),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Card(
                                                                          clipBehavior:
                                                                              Clip.antiAliasWithSaveLayer,
                                                                          color:
                                                                              Color(0xFF1A1A1A),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -0.06,
                                                                              -0.12),
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/809512_camera_multimedia_security_security_camera_surveillance_icon.png',
                                                                            width:
                                                                                35,
                                                                            height:
                                                                                35,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
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
                                                                                  'Camera 1',
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
                                                                                  'Living room',
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
                                                                        color: Color(
                                                                            0xFF00B89F),
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
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 5, 5, 0),
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color:
                                                            Color(0xFF272E36),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(3,
                                                                      0, 0, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    Container(
                                                                  width: 80,
                                                                  height: 80,
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          0xFF262626),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  child: Stack(
                                                                    children: [
                                                                      Card(
                                                                        clipBehavior:
                                                                            Clip.antiAliasWithSaveLayer,
                                                                        color: Color(
                                                                            0xFF1A1A1A),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -0.06,
                                                                            -0.12),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/809512_camera_multimedia_security_security_camera_surveillance_icon.png',
                                                                          width:
                                                                              35,
                                                                          height:
                                                                              35,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
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
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
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
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                'Camera 2',
                                                                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      color: Color(0xFF00B89F),
                                                                                    ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                'Dining room',
                                                                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                      fontFamily: 'Poppins',
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
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 5, 5, 0),
                                                      child: Card(
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        color:
                                                            Color(0xFF272E36),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(3,
                                                                      0, 0, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    Container(
                                                                  width: 80,
                                                                  height: 80,
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          0xFF262626),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  child: Stack(
                                                                    children: [
                                                                      Card(
                                                                        clipBehavior:
                                                                            Clip.antiAliasWithSaveLayer,
                                                                        color: Color(
                                                                            0xFF1A1A1A),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -0.06,
                                                                            -0.12),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/809512_camera_multimedia_security_security_camera_surveillance_icon.png',
                                                                          width:
                                                                              35,
                                                                          height:
                                                                              35,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
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
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
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
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                'Camera 3',
                                                                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                      fontFamily: 'Montserrat',
                                                                                      color: Color(0xFF00B89F),
                                                                                    ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Text(
                                                                                'Bedroom',
                                                                                style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                      fontFamily: 'Poppins',
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
                                                  ],
                                                )
                                              : Center(
                                                  child: Text(
                                                    'You do not have permission to view this content',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 15, 0, 0),
                                          child: _hasPermissionToViewVideo
                                              ? SingleChildScrollView(
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
                                                                .fromSTEB(
                                                                    3, 0, 0, 0),
                                                        child: Text(
                                                          'Today',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFFE5E5E5),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 5, 0, 3),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                await Navigator
                                                                    .push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            VideoPlayerScreen(),
                                                                    //
                                                                  ),
                                                                );
                                                              },
                                                              child: Container(
                                                                width: 90,
                                                                height: 90,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      0xFF535353),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              5,
                                                                              0,
                                                                              5,
                                                                              0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            '03:24',
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                  fontFamily: 'Poppins',
                                                                                  color: Color(0xFFE5E5E5),
                                                                                  fontSize: 10,
                                                                                  fontWeight: FontWeight.w100,
                                                                                ),
                                                                          ),
                                                                          Icon(
                                                                            Icons.cloud_download_rounded,
                                                                            color:
                                                                                Color(0xFF00B89F),
                                                                            size:
                                                                                18,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Image.asset(
                                                                      'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                      width: 35,
                                                                      height:
                                                                          25,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              10),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            'Living Room',
                                                                            style: FlutterFlowTheme.of(context).bodyText1.override(
                                                                                  fontFamily: 'Poppins',
                                                                                  color: Color(0xFFE5E5E5),
                                                                                  fontSize: 9,
                                                                                  fontWeight: FontWeight.w200,
                                                                                ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 90,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF535353),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          '03:24',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w100,
                                                                              ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .cloud_download_rounded,
                                                                          color:
                                                                              Color(0xFF00B89F),
                                                                          size:
                                                                              18,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                    width: 35,
                                                                    height: 25,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Living Room',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 9,
                                                                                fontWeight: FontWeight.w200,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 90,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF535353),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          '03:24',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w100,
                                                                              ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .cloud_download_rounded,
                                                                          color:
                                                                              Color(0xFF00B89F),
                                                                          size:
                                                                              18,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                    width: 35,
                                                                    height: 25,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Living Room',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 9,
                                                                                fontWeight: FontWeight.w200,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 90,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF535353),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          '03:24',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w100,
                                                                              ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .cloud_download_rounded,
                                                                          color:
                                                                              Color(0xFF00B89F),
                                                                          size:
                                                                              18,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                    width: 35,
                                                                    height: 25,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Living Room',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 9,
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
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            width: 90,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF535353),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        '03:24',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w100,
                                                                            ),
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .cloud_download_rounded,
                                                                        color: Color(
                                                                            0xFF00B89F),
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                  width: 35,
                                                                  height: 25,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Living Room',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 9,
                                                                              fontWeight: FontWeight.w200,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 90,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF535353),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        '03:24',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w100,
                                                                            ),
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .cloud_download_rounded,
                                                                        color: Color(
                                                                            0xFF00B89F),
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                  width: 35,
                                                                  height: 25,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Living Room',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 9,
                                                                              fontWeight: FontWeight.w200,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 90,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF535353),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        '03:24',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w100,
                                                                            ),
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .cloud_download_rounded,
                                                                        color: Color(
                                                                            0xFF00B89F),
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                  width: 35,
                                                                  height: 25,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Living Room',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 9,
                                                                              fontWeight: FontWeight.w200,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 90,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF535353),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        '03:24',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w100,
                                                                            ),
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .cloud_download_rounded,
                                                                        color: Color(
                                                                            0xFF00B89F),
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                  width: 35,
                                                                  height: 25,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Living Room',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 9,
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
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 20,
                                                                    0, 0),
                                                        child: Text(
                                                          'Yesterday',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Color(
                                                                    0xFFE5E5E5),
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 5, 0, 3),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              width: 90,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF535353),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          '03:24',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w100,
                                                                              ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .cloud_download_rounded,
                                                                          color:
                                                                              Color(0xFF00B89F),
                                                                          size:
                                                                              18,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                    width: 35,
                                                                    height: 25,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Living Room',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 9,
                                                                                fontWeight: FontWeight.w200,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 90,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF535353),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          '03:24',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w100,
                                                                              ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .cloud_download_rounded,
                                                                          color:
                                                                              Color(0xFF00B89F),
                                                                          size:
                                                                              18,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                    width: 35,
                                                                    height: 25,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Living Room',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 9,
                                                                                fontWeight: FontWeight.w200,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 90,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF535353),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            5,
                                                                            5,
                                                                            5),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          '03:24',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w100,
                                                                              ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .cloud_download_rounded,
                                                                          color:
                                                                              Color(0xFF00B89F),
                                                                          size:
                                                                              18,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                    width: 35,
                                                                    height: 25,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Living Room',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 9,
                                                                                fontWeight: FontWeight.w200,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 90,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF535353),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          '03:24',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w100,
                                                                              ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .cloud_download_rounded,
                                                                          color:
                                                                              Color(0xFF00B89F),
                                                                          size:
                                                                              18,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                    width: 35,
                                                                    height: 25,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Living Room',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 9,
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
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                            width: 90,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF535353),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        '03:24',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w100,
                                                                            ),
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .cloud_download_rounded,
                                                                        color: Color(
                                                                            0xFF00B89F),
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                  width: 35,
                                                                  height: 25,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Living Room',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 9,
                                                                              fontWeight: FontWeight.w200,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 90,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF535353),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        '03:24',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w100,
                                                                            ),
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .cloud_download_rounded,
                                                                        color: Color(
                                                                            0xFF00B89F),
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                  width: 35,
                                                                  height: 25,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Living Room',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 9,
                                                                              fontWeight: FontWeight.w200,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 90,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF535353),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        '03:24',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w100,
                                                                            ),
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .cloud_download_rounded,
                                                                        color: Color(
                                                                            0xFF00B89F),
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                  width: 35,
                                                                  height: 25,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Living Room',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 9,
                                                                              fontWeight: FontWeight.w200,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 90,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF535353),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5,
                                                                          5,
                                                                          5,
                                                                          5),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        '03:24',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w100,
                                                                            ),
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .cloud_download_rounded,
                                                                        color: Color(
                                                                            0xFF00B89F),
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Image.asset(
                                                                  'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                  width: 35,
                                                                  height: 25,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Living Room',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily: 'Poppins',
                                                                              color: Color(0xFFE5E5E5),
                                                                              fontSize: 9,
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
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 3, 0, 3),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Container(
                                                              width: 90,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF535353),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          '03:24',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w100,
                                                                              ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .cloud_download_rounded,
                                                                          color:
                                                                              Color(0xFF00B89F),
                                                                          size:
                                                                              18,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                    width: 35,
                                                                    height: 25,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Living Room',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 9,
                                                                                fontWeight: FontWeight.w200,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 90,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF535353),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          '03:24',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w100,
                                                                              ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .cloud_download_rounded,
                                                                          color:
                                                                              Color(0xFF00B89F),
                                                                          size:
                                                                              18,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                    width: 35,
                                                                    height: 25,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Living Room',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 9,
                                                                                fontWeight: FontWeight.w200,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 90,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF535353),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          '03:24',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w100,
                                                                              ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .cloud_download_rounded,
                                                                          color:
                                                                              Color(0xFF00B89F),
                                                                          size:
                                                                              18,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                    width: 35,
                                                                    height: 25,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Living Room',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 9,
                                                                                fontWeight: FontWeight.w200,
                                                                              ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 90,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFF535353),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          '03:24',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w100,
                                                                              ),
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .cloud_download_rounded,
                                                                          color:
                                                                              Color(0xFF00B89F),
                                                                          size:
                                                                              18,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Image.asset(
                                                                    'assets/images/2959742_broadcast_google_streaming_video_youtube_icon.png',
                                                                    width: 35,
                                                                    height: 25,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          'Living Room',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyText1
                                                                              .override(
                                                                                fontFamily: 'Poppins',
                                                                                color: Color(0xFFE5E5E5),
                                                                                fontSize: 9,
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
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Center(
                                                  child: Text(
                                                    'You do not have permission to view this content',
                                                    style: TextStyle(
                                                        color: Colors.white),
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
                          if (FFAppState().Chattoggle2 && FFAppState().chat)
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
                                          // Align(
                                          //   alignment: AlignmentDirectional(
                                          //       1.31, -0.83),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future fetchSList() async {
    final ApiCallResponse SList = await SeniorsList.call();
    print(SList.statusCode);
    // print(SList.jsonBody["seniors"]);
    _countries = SList.jsonBody["countries"];
    return SList.jsonBody["seniors"];
  }
}
