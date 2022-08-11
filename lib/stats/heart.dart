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

// ignore: must_be_immutable
class StatsWidget extends StatefulWidget {
  String data;
  StatsWidget({Key key, @required this.data}) : super(key: key);

  @override
  _StatsWidgetState createState() => _StatsWidgetState(data);
}

DateTime dateTime = DateTime.now();
String dateToday = DateFormat('dd-MM-yyyy').format(DateTime.now());
dynamic Hrate;
bool daily = true;
bool weekly = false;
bool monthly = false;
bool yearly = false;

DateTime dateTimeWeek = DateTime.now();
DateTime dateTimeMonth = DateTime.now();
DateTime dateTimeYear = DateTime.now();
DateTime _startDate = dateTimeWeek.subtract(Duration(days: 7));
DateTime _endDate = dateTimeWeek;
DateTime startDateMonth = dateTimeMonth.subtract(Duration(days: 30));
DateTime endDateMonth = dateTimeMonth;
DateTime startDateYear = dateTimeYear.subtract(Duration(days: 365));
DateTime endDateYear = dateTimeYear;

DateTimeRange dateRange = DateTimeRange(start: _startDate, end: _endDate);

class _StatsWidgetState extends State<StatsWidget> {
  bool checkLimit(DateTime limitDay) {
    if (limitDay.isBefore(_startDate)) {
      return false;
    } else if (limitDay.isAfter(_endDate)) {
      return false;
    }
    return true;
  }

  Future displayDateRangePicker(context) async {
    DateTimeRange newRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(dateTimeWeek.year - 7),
      lastDate: dateTimeWeek,
    );
    if (newRange == null) {
      return;
    }
    setState(() {
      dateRange = newRange;
    });
  }

  Future<dynamic> HeartStatus;
  Future<List<dynamic>> SList;

  List<HeartStat> hRate = [];
  List<HeartStatWeekMax> hRateMax = [];
  List<HeartStatWeekMax> hRateMin = [];
  List<HeartStatWeekMax> hRateMaxMon = [];
  List<HeartStatWeekMax> hRateMinMon = [];
  List<HeartStatWeekMax> hRateMinYr = [];
  List<HeartStatWeekMax> hRateMaxYr = [];
  GetHrate getHrate = GetHrate();
  String id;
  String wDate = DateFormat('yyyy-MM-dd').format(dateTimeWeek);
  String wDate1 = DateFormat('yyyy-MM-dd').format(dateTimeMonth);
  String wDate2 = DateFormat('yyyy-MM-dd').format(dateTimeYear);

  _StatsWidgetState(this.id);

  List<charts.Series<HeartStatWeekMax, String>> _createSampleData() {
    return [
      new charts.Series<HeartStatWeekMax, String>(
          id: 'max',
          domainFn: (HeartStatWeekMax sales, _) => sales.day,
          measureFn: (HeartStatWeekMax sales, _) => sales.Stat,
          data: hRateMax,
          colorFn: (_, __) => charts.Color.fromHex(code: "#00B89F"),
          labelAccessorFn: (HeartStatWeekMax sales, _) =>
              '\$${sales.Stat.toString()}'),
      new charts.Series<HeartStatWeekMax, String>(
          id: 'min',
          domainFn: (HeartStatWeekMax sales, _) => sales.day,
          measureFn: (HeartStatWeekMax sales, _) => sales.Stat,
          data: hRateMin,
          colorFn: (_, __) => charts.Color.fromHex(code: "#272E36"),
          labelAccessorFn: (HeartStatWeekMax sales, _) =>
              '\$${sales.Stat.toString()}'),
    ];
  }

  List<charts.Series<HeartStatWeekMax, String>> _createSampleDataMonth() {
    return [
      new charts.Series<HeartStatWeekMax, String>(
          id: 'max month',
          domainFn: (HeartStatWeekMax sales, _) => sales.day,
          measureFn: (HeartStatWeekMax sales, _) => sales.Stat,
          data: hRateMaxMon,
          colorFn: (_, __) => charts.Color.fromHex(code: "#00B89F"),
          labelAccessorFn: (HeartStatWeekMax sales, _) =>
              '\$${sales.Stat.toString()}'),
      new charts.Series<HeartStatWeekMax, String>(
          id: 'min month',
          domainFn: (HeartStatWeekMax sales, _) => sales.day,
          measureFn: (HeartStatWeekMax sales, _) => sales.Stat,
          data: hRateMinMon,
          colorFn: (_, __) => charts.Color.fromHex(code: "#272E36"),
          labelAccessorFn: (HeartStatWeekMax sales, _) =>
              '\$${sales.Stat.toString()}'),
    ];
  }

  List<charts.Series<HeartStatWeekMax, String>> _createSampleDataYear() {
    return [
      new charts.Series<HeartStatWeekMax, String>(
          id: 'max year',
          domainFn: (HeartStatWeekMax sales, _) => sales.day,
          measureFn: (HeartStatWeekMax sales, _) => sales.Stat,
          data: hRateMaxYr,
          colorFn: (_, __) => charts.Color.fromHex(code: "#00B89F"),
          labelAccessorFn: (HeartStatWeekMax sales, _) =>
              '\$${sales.Stat.toString()}'),
      new charts.Series<HeartStatWeekMax, String>(
          id: 'min year',
          domainFn: (HeartStatWeekMax sales, _) => sales.day,
          measureFn: (HeartStatWeekMax sales, _) => sales.Stat,
          data: hRateMinYr,
          colorFn: (_, __) => charts.Color.fromHex(code: "#272E36"),
          labelAccessorFn: (HeartStatWeekMax sales, _) =>
              '\$${sales.Stat.toString()}'),
    ];
  }

  @override
  void initState() {
    super.initState();
    daily = true;
    weekly = false;
    monthly = false;
    yearly = false;
    getHeartRate();
    getHeartWeekRate();
    getHeartMonthlyRate();
    getHeartYearlyRate();
    // SList = fetchSList();
    // int versionCode = BuildConfig.VERSION_CODE;
    // HeartStatus = fetchStat();
  }

//final List<charts.Series<HeartStatWeekMax, String>> seriesList = _createSampleData();
  void getHeartRate() async {
    print(id);
    String date = DateFormat('yyyy-MM-dd').format(dateTime);
    print(
        '${ApiService.domain}/graph/health_status/?senior_id=${id}&date=${date}');
    var response = await getHrate.get(
        '${ApiService.domain}/graph/health_status/?senior_id=${id}&date=${date}');

    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    print(rate["health_status"][0]["heart_rate"].runtimeType);

    List<HeartStat> temp =
        heartStatFromJson(rate["health_status"][0]["heart_rate"]);
    setState(() {
      hRate = temp;
    });
    print(hRate);
  }

  void getHeartWeekRate() async {
    wDate = DateFormat('yyyy-MM-dd').format(dateTimeWeek);
    print(wDate);
    var response = await getHrate.get(
        'http://18.208.148.208:4000/graph/health_status/heart_rate/weekly?date=${wDate}&senior_id=${id}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    print(rate["heart_rate"]);
    List<HeartStatWeekMax> temp = heartStatWeekMaxFromJson(rate["heart_rate"]);
    setState(() {
      hRateMax = temp;
    });
    List<HeartStatWeekMax> temp1 = heartStatWeekMinFromJson(rate["heart_rate"]);
    setState(() {
      hRateMin = temp1;
    });
  }

  void getHeartMonthlyRate() async {
    wDate1 = DateFormat('yyyy-MM-dd').format(dateTimeMonth);
    print(wDate);
    var response = await getHrate.get(
        'http://18.208.148.208:4000/graph/health_status/heart_rate/monthly?date=${wDate}&senior_id=${id}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    print(rate["heart_rate"]);
    List<HeartStatWeekMax> temp = heartStatWeekMaxFromJson(rate["heart_rate"]);
    setState(() {
      hRateMaxMon = temp;
    });
    List<HeartStatWeekMax> temp1 = heartStatWeekMinFromJson(rate["heart_rate"]);
    setState(() {
      hRateMinMon = temp1;
    });
  }

  String _time;
  Map<String, num> _measures;
  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    String time;
    final measures = <String, num>{};

    // We get the model that updated with a list of [SeriesDatum] which is
    // simply a pair of series & datum.
    //
    // Walk the selection updating the measures map, storing off the sales and
    // series name for each selection point.
    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.day;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.Stat;
        print(datumPair.datum.Stat);
        print(datumPair.datum.avg);
        print(datumPair.datum.max);
        print(datumPair.datum.min);
        Dialog errorDialog = Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          insetPadding: EdgeInsets.symmetric(horizontal: 120),

          //this right here
          child: Container(
            height: 80.0,
            width: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text(
                    'Maximum :' + datumPair.datum.max.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text(
                    'Minimum :' + datumPair.datum.min.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text(
                    'Average :' + datumPair.datum.avg.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          ),
        );

        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) => errorDialog);
      });
    }

    // Request a build.
    setState(() {
      _time = time;
      _measures = measures;
    });
  }

  void getHeartYearlyRate() async {
    wDate2 = DateFormat('yyyy-MM-dd').format(dateTimeMonth);
    print(wDate2);
    var response = await getHrate.get(
        'http://18.208.148.208:4000/graph/health_status/heart_rate/yearly?date=${wDate}&senior_id=${id}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    print(rate["heart_rate"]);
    List<HeartStatWeekMax> temp = heartStatWeekMaxFromJson(rate["heart_rate"]);
    setState(() {
      hRateMaxYr = temp;
    });
    List<HeartStatWeekMax> temp1 = heartStatWeekMinFromJson(rate["heart_rate"]);
    setState(() {
      hRateMinYr = temp1;
    });
  }

/*  Future<List<dynamic>> fetchSList() async {
    String wDate = DateFormat('yyyy-MM-dd').format(dateTimeWeek);
    print(wDate);
    final ApiCallResponse SList = await GetHeartWeek.call(id: id, date: wDate);
    print(SList.statusCode);
    print(SList.jsonBody);
    return SList.jsonBody;
  }*/

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var color1 = Color(0xFF00B89F);
  var color2 = Color(0xFF1A1A1A);
  var color3 = Color(0xFF1A1A1A);
  var color4 = Color(0xFF1A1A1A);

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
                        padding: EdgeInsetsDirectional.fromSTEB(20, 25, 20, 0),
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
                                      color4 = Color(0xFF1A1A1A);
                                      daily = true;
                                      weekly = false;
                                      monthly = false;
                                      yearly = false;
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
                                setState(() {
                                  color1 = Color(0xFF1A1A1A);
                                  color2 = Color(0xFF00B89F);
                                  color3 = Color(0xFF1A1A1A);
                                  color4 = Color(0xFF1A1A1A);
                                  weekly = true;
                                  daily = false;
                                  monthly = false;
                                  yearly = false;
                                  dateTimeWeek = DateTime.now();
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
                                    color4 = Color(0xFF1A1A1A);
                                    monthly = true;
                                    daily = false;
                                    weekly = false;
                                    yearly = false;
                                    dateTimeMonth = DateTime.now();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: color3,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                      topLeft: Radius.circular(0),
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
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  Monthly();
                                  setState(() {
                                    color1 = Color(0xFF1A1A1A);
                                    color2 = Color(0xFF1A1A1A);
                                    color3 = Color(0xFF1A1A1A);
                                    color4 = Color(0xFF00B89F);
                                    monthly = false;
                                    daily = false;
                                    weekly = false;
                                    yearly = true;
                                    dateTimeYear = DateTime.now();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: color4,
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
                                          'Yearly',
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                print(DateFormat('dd-MM-yyyy')
                                    .format(dateTimeWeek));

                                print(DateFormat('dd-MM-yyyy')
                                    .format(dateTimeWeek));
                                if (daily) {
                                  setState(() {
                                    dateTime =
                                        dateTime.subtract(Duration(days: 1));
                                    getHeartRate();
                                  });
                                }
                                if (weekly == true) {
                                  dateTimeWeek =
                                      dateTimeWeek.subtract(Duration(days: 1));
                                  setState(() {
                                    _startDate = dateTimeWeek
                                        .subtract(Duration(days: 7));
                                    _endDate = dateTimeWeek;
                                  });

                                  getHeartWeekRate();
                                } else if (monthly == true) {
                                  dateTimeMonth = dateTimeMonth
                                      .subtract(Duration(days: 30));
                                  setState(() {
                                    startDateMonth = startDateMonth
                                        .subtract(Duration(days: 30));
                                    endDateMonth = dateTimeMonth;
                                  });
                                  getHeartMonthlyRate();
                                } else if (yearly == true) {
                                  dateTimeYear = dateTimeYear
                                      .subtract(Duration(days: 365));
                                  setState(() {
                                    startDateYear = startDateYear
                                        .subtract(Duration(days: 365));
                                    endDateYear = dateTimeYear;
                                  });
                                  getHeartYearlyRate();
                                }
                              },
                              icon: Icon(
                                Icons.chevron_left,
                                color: Color(0xFFAFAFAF),
                                size: 32,
                              ),
                            ),
                            if (daily ?? true)
                              Expanded(
                                child: Text(
                                  DateFormat('dd-MM-yyyy').format(dateTime),
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
                            if (weekly == true)
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 10, 5, 10),
                                  child: InkWell(
                                    onTap: () async {
                                      await displayDateRangePicker(context);
                                    },
                                    child: Text(
                                      '${DateFormat('d / MM / y').format(_startDate)} - ${DateFormat('d / MM / y').format(_endDate)}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFAFAFAF),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),

                                      //style: kWhite20RegularTextStyle,
                                    ),
                                  )),
                            if (monthly == true)
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 10, 5, 10),
                                  child: InkWell(
                                    onTap: () async {
                                      await displayDateRangePicker(context);
                                    },
                                    child: Text(
                                      '${DateFormat('d / MM / y').format(startDateMonth)} - ${DateFormat('d / MM / y').format(endDateMonth)}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFAFAFAF),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),

                                      //style: kWhite20RegularTextStyle,
                                    ),
                                  )),
                            if (yearly == true)
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 10, 5, 10),
                                  child: InkWell(
                                    onTap: () async {
                                      await displayDateRangePicker(context);
                                    },
                                    child: Text(
                                      '${DateFormat('d / MM / y').format(startDateYear)} - ${DateFormat('d / MM / y').format(endDateYear)}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFAFAFAF),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),

                                      //style: kWhite20RegularTextStyle,
                                    ),
                                  )),
                            IconButton(
                              onPressed: () {
                                print(DateFormat('dd-MM-yyyy')
                                    .format(dateTimeWeek));

                                print(DateFormat('dd-MM-yyyy')
                                    .format(dateTimeWeek));
                                if (daily) {
                                  setState(() {
                                    if ((DateFormat('dd-MM-yyyy')
                                            .format(dateTime)) !=
                                        dateToday) {
                                      dateTime =
                                          dateTime.add(Duration(days: 1));
                                      getHeartRate();
                                    }
                                  });
                                } else if (weekly == true) {
                                  if ((DateFormat('dd-MM-yyyy')
                                          .format(dateTimeWeek)) !=
                                      dateToday) {
                                    dateTimeWeek =
                                        dateTimeWeek.add(Duration(days: 1));
                                    setState(() {
                                      _startDate = dateTimeWeek
                                          .subtract(Duration(days: 7));
                                      _endDate = dateTimeWeek;
                                    });

                                    getHeartWeekRate();
                                  }
                                } else if (monthly == true) {
                                  if ((DateFormat('dd-MM-yyyy')
                                          .format(dateTimeMonth)) !=
                                      dateToday) {
                                    dateTimeMonth =
                                        dateTimeMonth.add(Duration(days: 30));
                                    setState(() {
                                      startDateMonth = startDateMonth
                                          .subtract(Duration(days: 30));
                                      endDateMonth = dateTimeMonth;
                                    });
                                    getHeartMonthlyRate();
                                  }
                                } else if (yearly == true) {
                                  if ((DateFormat('dd-MM-yyyy')
                                          .format(dateTimeMonth)) !=
                                      dateToday) {
                                    dateTimeYear =
                                        dateTimeYear.add(Duration(days: 365));
                                    setState(() {
                                      startDateYear = startDateYear
                                          .subtract(Duration(days: 365));
                                      endDateYear = dateTimeYear;
                                    });
                                    getHeartYearlyRate();
                                  }
                                }
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
                      if (daily == true)
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
                                    renderSpec:
                                        new charts.SmallTickRendererSpec(
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
                      if (weekly == true && daily == false)
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                            child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 3,
                                decoration: BoxDecoration(
                                    color: Color(0xFF272E36),
                                    borderRadius: BorderRadius.circular(10)),
                                child: charts.BarChart(
                                  _createSampleData(),
                                  /* selectionModels: [
                                    charts.SelectionModelConfig(changedListener:
                                        (charts.SelectionModel model) {
                                      if (model.hasDatumSelection)
                                        print(model.selectedSeries[0].measureFn(
                                            model.selectedDatum[0].index));
                                      print(model.selectedSeries[0].domainFn(
                                          model.selectedDatum[1].index));
                                    })
                                  ],*/
                                  selectionModels: [
                                    new charts.SelectionModelConfig(
                                        type: charts.SelectionModelType.info,
                                        changedListener: _onSelectionChanged)
                                  ],
                                  domainAxis: new charts.OrdinalAxisSpec(
                                      renderSpec:
                                          new charts.SmallTickRendererSpec(
                                    labelStyle: new charts.TextStyleSpec(
                                        fontSize: 6, // size in Pts.
                                        color: charts.MaterialPalette.white),
                                  )),
                                  /*  primaryMeasureAxis:
                                      new charts.NumericAxisSpec(
                                          renderSpec:
                                              new charts.GridlineRendererSpec(
                                    labelStyle: new charts.TextStyleSpec(
                                        fontSize: 8, // size in Pts.
                                        color: charts.MaterialPalette.white),
                                  )),*/

                                  animate: true,
                                  defaultRenderer: new charts.BarRendererConfig(
                                      groupingType:
                                          charts.BarGroupingType.stacked,
                                      strokeWidthPx: 0.5,
                                      maxBarWidthPx: 10),
                                )
                                //barGroupingType:  charts.BarGroupingType.stacked, strokeWidthPx: 2.0)),
                                )),
                      if (weekly == false && daily == false && monthly == true)
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                            child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 3,
                                decoration: BoxDecoration(
                                    color: Color(0xFF272E36),
                                    borderRadius: BorderRadius.circular(10)),
                                child: charts.BarChart(
                                  _createSampleDataMonth(),
                                  selectionModels: [
                                    new charts.SelectionModelConfig(
                                        type: charts.SelectionModelType.info,
                                        changedListener: _onSelectionChanged)
                                  ],
                                  domainAxis: new charts.OrdinalAxisSpec(
                                      renderSpec:
                                          new charts.SmallTickRendererSpec(
                                    labelStyle: new charts.TextStyleSpec(
                                        fontSize: 3, // size in Pts.
                                        color: charts.MaterialPalette.white),
                                  )),
                                  animate: true,
                                  defaultRenderer: new charts.BarRendererConfig(
                                      groupingType:
                                          charts.BarGroupingType.stacked,
                                      strokeWidthPx: 0.5,
                                      maxBarWidthPx: 10),
                                )
                                //barGroupingType:  charts.BarGroupingType.stacked, strokeWidthPx: 2.0)),
                                )),
                      if (weekly == false &&
                          daily == false &&
                          monthly == false &&
                          yearly == true)
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                            child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height / 3,
                                decoration: BoxDecoration(
                                    color: Color(0xFF272E36),
                                    borderRadius: BorderRadius.circular(10)),
                                child: charts.BarChart(
                                  _createSampleDataYear(),
                                  selectionModels: [
                                    new charts.SelectionModelConfig(
                                        type: charts.SelectionModelType.info,
                                        changedListener: _onSelectionChanged)
                                  ],
                                  domainAxis: new charts.OrdinalAxisSpec(
                                      renderSpec:
                                          new charts.SmallTickRendererSpec(
                                    labelStyle: new charts.TextStyleSpec(
                                        fontSize: 3, // size in Pts.
                                        color: charts.MaterialPalette.white),
                                  )),
                                  animate: true,
                                  defaultRenderer: new charts.BarRendererConfig(
                                      groupingType:
                                          charts.BarGroupingType.stacked,
                                      strokeWidthPx: 0.5,
                                      maxBarWidthPx: 10),
                                )
                                //barGroupingType:  charts.BarGroupingType.stacked, strokeWidthPx: 2.0)),
                                )),
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

List<HeartStatWeekMax> heartStatWeekMaxFromJson(List<dynamic> rate) {
  List<HeartStatWeekMax> heart = [];

  rate.forEach((element) {
    heart.add(HeartStatWeekMax(element["date"], element["max_min"],
        element["avg"], element["max"], element["min"]));
  });
  return heart;
}

List<HeartStatWeekMax> heartStatWeekMinFromJson(List<dynamic> rate) {
  List<HeartStatWeekMax> heart = [];

  rate.forEach((element) {
    heart.add(HeartStatWeekMax(element["date"], element["min"], element["avg"],
        element["max"], element["min"]));
  });
  return heart;
}

// List<HeartStat>.from(json.decode(str).map((x) => HeartStat.fromJson(x)));

String heartStatToJson(List<HeartStat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HeartStatWeekMax {
  final String day;
  final int Stat;
  final int avg;
  final int max;
  final int min;

  HeartStatWeekMax(this.day, this.Stat, this.avg, this.max, this.min);
}

class HeartStat {
  HeartStat({
    this.time,
    this.value,
  });

  int time;
  int value;

  factory HeartStat.fromJson(Map<String, dynamic> json) => HeartStat(
        time: json["time"],
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
