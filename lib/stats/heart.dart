import 'dart:convert';
import 'dart:ui';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:n_tel_care_family_app/backend/ApiService.dart';
import 'package:n_tel_care_family_app/backend/api_requests/api_calls.dart';
import 'package:n_tel_care_family_app/landing/landing.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:month_year_picker/month_year_picker.dart';

class StatsWidget extends StatefulWidget {
  String data;
  StatsWidget({Key key, @required this.data}) : super(key: key);

  @override
  _StatsWidgetState createState() => _StatsWidgetState(data);
}

DateTime dateTime;
dynamic Hrate;
bool daily = true;
bool weekly = false;
bool monthly = false;

class _StatsWidgetState extends State<StatsWidget> {
  Future<dynamic> HeartStatus;
  List<HeartStat> hRate = [];
  GetHrate getHrate = GetHrate();
  String id;
  _StatsWidgetState(this.id);
  @override
  void initState() {
    super.initState();
    getHeartRate();
    // int versionCode = BuildConfig.VERSION_CODE;
    // HeartStatus = fetchStat();
  }

  void getHeartRate() async {
    var response = await getHrate
        .get('${ApiService.domain}/graph/health_status/?senior_id=${id}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    print(rate["health_status"]["heart_rate"].runtimeType);

    List<HeartStat> temp =
        heartStatFromJson(rate["health_status"]["heart_rate"]);
    setState(() {
      hRate = temp;
    });
    print(hRate);
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var color1 = Color(0xFF00B89F);
  var color2 = Color(0xFF1A1A1A);
  var color3 = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<HeartStat, int>> heart = [
      charts.Series(
          data: hRate,
          id: "Heart Rate",
          domainFn: (HeartStat pops, _) => pops.time,
          measureFn: (HeartStat pops, _) => pops.value,
          colorFn: (HeartStat pops, _) =>
              charts.ColorUtil.fromDartColor(Colors.red))
    ];

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF1F252B),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        'assets/images/15-health.svg',
                        width: 220,
                        height: 220,
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 63, 0, 0),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.pop(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ModifiedLandingPageWidget(),
                                ));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.chevron_left_sharp,
                                color: Color(0xFFAFAFAF),
                                size: 45,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: Text(
                              'Heart Rate',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFFAFAFAF),
                                    fontSize: 35,
                                    fontWeight: FontWeight.w200,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(50, 25, 50, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      color1 = Color(0xFF00B89F);
                                      color2 = Color(0xFF1A1A1A);
                                      color3 = Color(0xFF1A1A1A);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: color1,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Daily',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF6D6767),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                            Expanded(
                                child: InkWell(
                              onTap: () async {
                                if (weekly == true) {
                                  weekly = false;
                                } else
                                  weekly = false;
                                setState(() {
                                  color1 = Color(0xFF1A1A1A);
                                  color2 = Color(0xFF00B89F);
                                  color3 = Color(0xFF1A1A1A);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: color2,
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Weekly',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF6D6767),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w200,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  Monthly();
                                  setState(() {
                                    color1 = Color(0xFF1A1A1A);
                                    color2 = Color(0xFF1A1A1A);
                                    color3 = Color(0xFF00B89F);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: color3,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(10),
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Monthly',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF6D6767),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w200,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // if (daily == true)
                      //   Daily()
                      // else if (monthly == true)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: dateTime == null
                                            ? DateTime.now()
                                            : dateTime,
                                        firstDate: DateTime(2001),
                                        lastDate: DateTime.now())
                                    .then((date) {
                                  setState(() {
                                    dateTime = date;
                                  });
                                  getHeartRate();
                                });
                              },
                              icon: Icon(
                                Icons.chevron_left,
                                color: Color(0xFFAFAFAF),
                                size: 32,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                dateTime == null
                                    ? DateFormat('dd-MM-yyyy')
                                        .format(DateTime.now())
                                    : DateFormat('dd-MM-yyyy').format(dateTime),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFAFAFAF),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: dateTime == null
                                            ? DateTime.now()
                                            : dateTime,
                                        firstDate: DateTime(2001),
                                        lastDate: DateTime.now())
                                    .then((date) {
                                  setState(() {
                                    dateTime = date;
                                  });
                                });
                              },
                              icon: Icon(
                                Icons.chevron_right,
                                color: Color(0xFFAFAFAF),
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 3,
                            decoration: BoxDecoration(
                                color: Color(0xFF272E36),
                                borderRadius: BorderRadius.circular(10)),
                            child: charts.LineChart(
                              heart,
                              domainAxis: new charts.NumericAxisSpec(
                                  tickProviderSpec:
                                      charts.BasicNumericTickProviderSpec(
                                          zeroBound: false),
                                  renderSpec: new charts.SmallTickRendererSpec(
                                    labelStyle: new charts.TextStyleSpec(
                                        fontSize: 8, // size in Pts.
                                        color: charts.MaterialPalette.white),
                                  )),
                              primaryMeasureAxis: new charts.NumericAxisSpec(
                                  renderSpec: new charts.GridlineRendererSpec(
                                labelStyle: new charts.TextStyleSpec(
                                    fontSize: 8, // size in Pts.
                                    color: charts.MaterialPalette.white),
                              )),

                              // domainAxis: charts.OrdinalAxisSpec(
                              //     renderSpec: charts.SmallTickRendererSpec(
                              //         labelStyle: new charts.TextStyleSpec(
                              //             color: charts.MaterialPalette.white))),
                            ),
                          )
                          // Image.asset(
                          //   'assets/images/heartRate.png',
                          //   width: 400,
                          //   height: 400,
                          //   fit: BoxFit.fill,
                          // ),
                          ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: Color(0xFF00B89F),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 2.5, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Heart rate Range',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFFE5E5E5),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 2.5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 1),
                                              child: Text(
                                                '60 - 138',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFE5E5E5),
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 0, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                'times/min',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFE5E5E5),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w200,
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
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Color(0xFF272E36),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 2.5, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Resting rate Range',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFFE5E5E5),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 2.5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 0, 1),
                                                child: Text(
                                                  '60 ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFFE5E5E5),
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'times/min',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFFE5E5E5),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w200,
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
                          ],
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
    );
  }
}

List<HeartStat> heartStatFromJson(List<dynamic> rate) {
  List<HeartStat> heart = [];
  rate.forEach((element) {
    heart.add(HeartStat.fromJson(element));
  });
  return heart;
}
// List<HeartStat>.from(json.decode(str).map((x) => HeartStat.fromJson(x)));

String heartStatToJson(List<HeartStat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HeartStat {
  HeartStat({
    this.time,
    this.value,
  });

  int time;
  int value;

  factory HeartStat.fromJson(Map<String, dynamic> json) => HeartStat(
        time: int.parse(json["time"]),
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "value": value,
      };
}

class Daily extends StatefulWidget {
  const Daily({Key key}) : super(key: key);

  @override
  State<Daily> createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate: dateTime == null ? DateTime.now() : dateTime,
                      firstDate: DateTime(2001),
                      lastDate: DateTime.now())
                  .then((date) {
                setState(() {
                  dateTime = date;
                });
              });
            },
            icon: Icon(
              Icons.chevron_left,
              color: Color(0xFFAFAFAF),
              size: 32,
            ),
          ),
          Expanded(
            child: Text(
              dateTime == null
                  ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                  : DateFormat('dd-MM-yyyy').format(dateTime),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Color(0xFFAFAFAF),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
          IconButton(
            onPressed: () {
              showMonthYearPicker(
                      context: context,
                      initialDate: dateTime == null ? DateTime.now() : dateTime,
                      firstDate: DateTime(2001),
                      lastDate: DateTime.now())
                  .then((date) {
                setState(() {
                  dateTime = date;
                });
              });
            },
            icon: Icon(
              Icons.chevron_right,
              color: Color(0xFFAFAFAF),
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

class Monthly extends StatefulWidget {
  const Monthly({Key key}) : super(key: key);

  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Daily> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate: dateTime == null ? DateTime.now() : dateTime,
                      firstDate: DateTime(2001),
                      lastDate: DateTime.now())
                  .then((date) {
                setState(() {
                  dateTime = date;
                });
              });
            },
            icon: Icon(
              Icons.chevron_left,
              color: Color(0xFFAFAFAF),
              size: 32,
            ),
          ),
          Expanded(
            child: Text(
              dateTime == null
                  ? DateFormat('dd-MM-yyyy').format(DateTime.now())
                  : DateFormat('dd-MM-yyyy').format(dateTime),
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Color(0xFFAFAFAF),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
            ),
          ),
          IconButton(
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate: dateTime == null ? DateTime.now() : dateTime,
                      firstDate: DateTime(2001),
                      lastDate: DateTime.now())
                  .then((date) {
                setState(() {
                  dateTime = date;
                });
              });
            },
            icon: Icon(
              Icons.chevron_right,
              color: Color(0xFFAFAFAF),
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
