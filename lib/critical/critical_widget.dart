import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:n_tel_care_family_app/backend/ApiService.dart';
import 'package:n_tel_care_family_app/backend/api_requests/api_calls.dart';
import 'package:n_tel_care_family_app/chat/chat_widget.dart';
import 'package:n_tel_care_family_app/core/shared_preferences_service.dart';
import 'package:n_tel_care_family_app/seniors_list/edit_seniors.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CriticalWidget extends StatefulWidget {
  const CriticalWidget({Key key}) : super(key: key);

  @override
  _CriticalWidgetState createState() => _CriticalWidgetState();
}

class _CriticalWidgetState extends State<CriticalWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<dynamic> SList;
  int isSelected = 0;
  String _seniorId;
  List<dynamic> _eventList;
  List<dynamic> _countries;
  DateTime date = DateTime.now();
  bool _isEventDataLoading = true;

  _isSelected(int index) {
    setState(() {
      isSelected = index;
    });
  }

  @override
  void initState() {
    super.initState();
    SList = fetchSList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadEvents({bool init = false}) async {
    if (!init) {
      setState(() {
        _isEventDataLoading = true;
      });
    }
    String uri =
        "${ApiService.domain}/notification/senior?senior_id=$_seniorId&date=${DateFormat("yyyy-MM-dd").format(date)}";
    Response res = await Dio().get(uri,
        options: Options(headers: {
          "Authorization":
              "Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}"
        }));
    _eventList = res.data["data"];
    setState(() {
      _isEventDataLoading = false;
    });
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
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: InkWell(
                              onTap: () async {
                                /*await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NavBarPage(initialPage: 'Landing'),
                                ),
                              );*/
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.chevron_left_sharp,
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Text(
                            'Critical Events \nNotifications',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w300,
                                    ),
                          ),
                        ),
                      ],
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
                              return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                                _seniorId = inf[index]["id"];
                                                print(
                                                    "id changed to $_seniorId");
                                                _isSelected(index);
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 20, 0, 0),
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
                                                              inf[index]
                                                                  ["lname"],
                                                          textAlign:
                                                              TextAlign.center,
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
                                                              inf[index]
                                                                  ["age"] +
                                                              ", " +
                                                              inf[index]
                                                                  ["gender"],
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
                                                              builder: (context) => EditSeniorsWidget(
                                                                  countries:
                                                                      _countries,
                                                                  data: snapshot
                                                                          .data[
                                                                      index])));
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      6, 0, 0),
                                                          child: Text(
                                                            'More Info',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
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
                        padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFF1F252B),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        date.year == DateTime.now().year &&
                                                date.month ==
                                                    DateTime.now().month &&
                                                date.day == DateTime.now().day
                                            ? "Today"
                                            : (date.year ==
                                                        DateTime.now().year &&
                                                    date.month ==
                                                        DateTime.now().month &&
                                                    date.day ==
                                                        DateTime.now()
                                                            .subtract(Duration(
                                                                days: 1))
                                                            .day
                                                ? "Yesterday"
                                                : DateFormat("dd MMM, yyyy")
                                                    .format(date)),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFFAFAFAF),
                                            ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'Sort ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFFD8D8D8),
                                                ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 12, 0),
                                            child: SvgPicture.asset(
                                              'assets/images/9055020_bx_sort_icon.svg',
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              DateTime _date =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: date,
                                                      firstDate:
                                                          DateTime(1900, 8),
                                                      lastDate: DateTime.now());
                                              if (_date != null &&
                                                  _date != date) {
                                                setState(() {
                                                  date = _date;
                                                });
                                                _loadEvents();
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 10, 0),
                                                  child: Text(
                                                    'Filter By',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              Color(0xFFAFAFAF),
                                                        ),
                                                  ),
                                                ),
                                                FaIcon(
                                                  FontAwesomeIcons.calendarAlt,
                                                  color: Color(0xFF00B89F),
                                                  size: 19,
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: !_isEventDataLoading
                                      ? (_eventList.length == 0
                                          ? Center(
                                              child: Text(
                                                "Your events will be shown here",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          : ListView.builder(
                                              itemCount: _eventList.length,
                                              itemBuilder: (_, int index) =>
                                                  Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 5, 5, 0),
                                                child: Card(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  color: Color(0xFF272E36),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                3, 0, 0, 0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: Container(
                                                            width: 80,
                                                            height: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF262626),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            child: Stack(
                                                              children: [
                                                                Card(
                                                                  clipBehavior:
                                                                      Clip.antiAliasWithSaveLayer,
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -0.06,
                                                                          -0.12),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Group_706.png',
                                                                    width: 35,
                                                                    height: 35,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
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
                                                                    'jolly\'s Smart band not Worn',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          color:
                                                                              Color(0xFFFFCC00),
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
                                                                    '14:20 hrs',
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
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))
                                      : Center(
                                          child: CircularProgressIndicator(),
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
                if (FFAppState().chat && FFAppState().Chattoggle2)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 90, 0, 10),
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
    _countries = SList.jsonBody["countries"];
    if ((SList.jsonBody["seniors"] as List<dynamic>).length != 0)
      _seniorId = (SList.jsonBody["seniors"] as List<dynamic>)[0]["id"];
    _loadEvents(init: true);
    return SList.jsonBody["seniors"];
  }
}
