import 'dart:convert';

import 'package:n_tel_care_family_app/backend/api_requests/api_calls.dart';
import 'package:n_tel_care_family_app/landing/landing.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DoorWidget extends StatefulWidget {
  String data;
  DoorWidget({Key key, @required this.data}) : super(key: key);

  @override
  _DoorWidgetState createState() => _DoorWidgetState(data);
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

class _DoorWidgetState extends State<DoorWidget> {
  @override
  void initState() {
    super.initState();
    daily = true;
    weekly = false;
    monthly = false;
    yearly = false;
    getStepscount();
    getStepWeekRate();
    getStepMonthlyRate();
    getStepYearlyRate();
  }

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

  //List<HeartStat> hRate = [];
  List<StepStatMonth> stepMax = [];

  List<StepStatMonth> stepMaxMon = [];

  List<StepStatMax> stepMinYr = [];
  List<StepStatMax> stepMaxYr = [];
  GetHrate getHrate = GetHrate();
  String id;
  String wDate = DateFormat('yyyy-MM-dd').format(dateTimeWeek);
  String wDate1 = DateFormat('yyyy-MM-dd').format(dateTimeMonth);
  String wDate2 = DateFormat('yyyy-MM-dd').format(dateTimeYear);

  Future<dynamic> Stepcount;
  List<StepsStat> stepStat = [];
  GetSteps getSteps = GetSteps();

  _DoorWidgetState(this.id);

  void getStepscount() async {
    String date = DateFormat('yyyy-MM-dd').format(dateTime);
    var response = await getHrate.get(
        'http://18.208.148.208:4000/graph/health_status/?senior_id=${id}&date=${date}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    //  print(rate["health_status"]["heart_rate"].runtimeType);

    List<StepsStat> temp = stepsStatFromJson(rate["health_status"][0]["Door"]);
    setState(() {
      stepStat = temp;
    });
    print(stepStat);
  }

  List<charts.Series<StepsStat, String>> _createSampleDataDaily() {
    return [
      new charts.Series<StepsStat, String>(
          id: 'daily4',
          domainFn: (StepsStat sales, _) => sales.time,
          measureFn: (StepsStat sales, _) => sales.value,
          data: stepStat,
          colorFn: (_, __) => charts.Color.fromHex(code: "#00B89F"),
          labelAccessorFn: (StepsStat sales, _) =>
              '\$${sales.value.toString()}'),
    ];
  }

  List<charts.Series<StepStatMonth, String>> _createSampleData() {
    return [
      new charts.Series<StepStatMonth, String>(
          id: 'max2',
          domainFn: (StepStatMonth sales, _) => sales.day,
          measureFn: (StepStatMonth sales, _) => sales.Stat,
          data: stepMax,
          colorFn: (_, __) => charts.Color.fromHex(code: "#00B89F"),
          labelAccessorFn: (StepStatMonth sales, _) =>
              '\$${sales.Stat.toString()}'),
    ];
  }

  List<charts.Series<StepStatMonth, String>> _createSampleDataMonth() {
    return [
      new charts.Series<StepStatMonth, String>(
          id: 'max1',
          domainFn: (StepStatMonth sales, _) => sales.day,
          measureFn: (StepStatMonth sales, _) => sales.Stat,
          data: stepMaxMon,
          colorFn: (_, __) => charts.Color.fromHex(code: "#00B89F"),
          labelAccessorFn: (StepStatMonth sales, _) =>
              '\$${sales.Stat.toString()}')
    ];
  }

  List<charts.Series<StepStatMax, String>> _createSampleDataYear() {
    return [
      new charts.Series<StepStatMax, String>(
          id: 'max5',
          domainFn: (StepStatMax sales, _) => sales.day,
          measureFn: (StepStatMax sales, _) => sales.Stat,
          data: stepMaxYr,
          colorFn: (_, __) => charts.Color.fromHex(code: "#00B89F"),
          labelAccessorFn: (StepStatMax sales, _) =>
              '\$${sales.Stat.toString()}'),
      new charts.Series<StepStatMax, String>(
          id: 'min5',
          domainFn: (StepStatMax sales, _) => sales.day,
          measureFn: (StepStatMax sales, _) => sales.Stat,
          data: stepMinYr,
          colorFn: (_, __) => charts.Color.fromHex(code: "#272E36"),
          labelAccessorFn: (StepStatMax sales, _) =>
              '\$${sales.Stat.toString()}'),
    ];
  }

//final List<charts.Series<HeartStatWeekMax, String>> seriesList = _createSampleData();

  void getStepWeekRate() async {
    wDate1 = DateFormat('yyyy-MM-dd').format(dateTimeWeek);
    print(wDate);
    var response = await getHrate.get(
        'http://18.208.148.208:4000/graph/health_status/Door/weekly?date=${wDate}&senior_id=${id}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    print(rate["Door"]);
    List<StepStatMonth> temp = StepStatWeekFromJson(rate["Door"]);
    setState(() {
      stepMax = temp;
    });
  }

  void getStepMonthlyRate() async {
    wDate1 = DateFormat('yyyy-MM-dd').format(dateTimeMonth);
    print(wDate1);
    var response = await getHrate.get(
        'http://18.208.148.208:4000/graph/health_status/Door/monthly?date=${wDate1}&senior_id=${id}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    print(rate["Door"]);
    List<StepStatMonth> temp = StepStatWeekFromJson(rate["Door"]);
    setState(() {
      stepMaxMon = temp;
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

  String _time1;
  Map<String, num> _measures1;
  _onSelectionChanged1(charts.SelectionModel model) {
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
        //print(datumPair.datum.Stat);
        /*  String val;
        if (datumPair.datum.Stat == 100) {
          val = "Opened";
        } else {
          val = "Closed";
        }*/
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
                    'Date :' + datumPair.datum.day.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text(
                    'Count of hours door was opened :' +
                        datumPair.datum.Stat.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                ),
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

  void getStepYearlyRate() async {
    wDate2 = DateFormat('yyyy-MM-dd').format(dateTimeMonth);
    print(wDate2);
    var response = await getHrate.get(
        'http://18.208.148.208:4000/graph/health_status/Door/yearly?date=${wDate2}&senior_id=${id}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    print(rate["Door"]);
    List<StepStatMax> temp = StepStatWeekMaxFromJson(rate["Door"]);
    setState(() {
      stepMaxYr = temp;
    });
    List<StepStatMax> temp1 = StepStatWeekMinFromJson(rate["Door"]);
    setState(() {
      stepMinYr = temp1;
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var color1 = Color(0xFF00B89F);
  var color2 = Color(0xFF1A1A1A);
  var color3 = Color(0xFF1A1A1A);
  var color4 = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'assets/images/door.svg',
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
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Text(
                            'Door Sensor',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
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
                                    // getStepscount();
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
                                //   getStepWeekRate();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: color2,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
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
                                  getStepMonthlyRate();
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  //  getStepYearlyRate();
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  getStepscount();
                                });
                              }
                              if (weekly == true) {
                                dateTimeWeek =
                                    dateTimeWeek.subtract(Duration(days: 1));
                                setState(() {
                                  _startDate =
                                      dateTimeWeek.subtract(Duration(days: 7));
                                  _endDate = dateTimeWeek;
                                });

                                getStepWeekRate();
                              } else if (monthly == true) {
                                dateTimeMonth =
                                    dateTimeMonth.subtract(Duration(days: 30));
                                setState(() {
                                  startDateMonth = startDateMonth
                                      .subtract(Duration(days: 30));
                                  endDateMonth = dateTimeMonth;
                                });
                                getStepMonthlyRate();
                              } else if (yearly == true) {
                                dateTimeYear =
                                    dateTimeYear.subtract(Duration(days: 365));
                                setState(() {
                                  startDateYear = startDateYear
                                      .subtract(Duration(days: 365));
                                  endDateYear = dateTimeYear;
                                });
                                getStepYearlyRate();
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
                              if (daily) {
                                setState(() {
                                  if ((DateFormat('dd-MM-yyyy')
                                          .format(dateTime)) !=
                                      dateToday) {
                                    dateTime = dateTime.add(Duration(days: 1));
                                    getStepscount();
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

                                  getStepWeekRate();
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
                                  getStepMonthlyRate();
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
                                  getStepYearlyRate();
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Text(
                            'Last Used',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFFAFAFAF),
                                      fontSize: 35,
                                      fontWeight: FontWeight.w200,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    if (daily == true &&
                        weekly == false &&
                        monthly == false &&
                        yearly == false)
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
                              _createSampleDataDaily(),
                              vertical: false,
                              domainAxis: new charts.OrdinalAxisSpec(
                                  renderSpec: new charts.SmallTickRendererSpec(
                                labelStyle: new charts.TextStyleSpec(
                                    fontSize: 6, // size in Pts.
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
                    if (weekly ?? true)
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
                                selectionModels: [
                                  new charts.SelectionModelConfig(
                                      type: charts.SelectionModelType.info,
                                      changedListener: _onSelectionChanged1)
                                ],
                                vertical: true,
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
                    if (monthly ?? true)
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
                                vertical: true,
                                selectionModels: [
                                  new charts.SelectionModelConfig(
                                      type: charts.SelectionModelType.info,
                                      changedListener: _onSelectionChanged1)
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
                    if (yearly ?? true)
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
                                vertical: true,
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
                              ))
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

List<StepStatMax> StepStatWeekMinFromJson(List<dynamic> rate) {
  List<StepStatMax> heart = [];

  rate.forEach((element) {
    heart.add(StepStatMax(element["date"], element["min"], element["avg"],
        element["max"], element["min"]));
  });
  return heart;
}

List<StepStatMax> StepStatWeekMaxFromJson(List<dynamic> rate) {
  List<StepStatMax> heart = [];

  rate.forEach((element) {
    heart.add(StepStatMax(element["date"], element["max_min"], element["avg"],
        element["max"], element["min"]));
  });
  return heart;
}

class StepStatMax {
  final String day;
  final int Stat;
  final int avg;
  final int max;
  final int min;

  StepStatMax(this.day, this.Stat, this.avg, this.max, this.min);
}

class StepStatMonth {
  final String day;
  final int Stat;

  StepStatMonth(this.day, this.Stat);
}

List<StepsStat> stepsStatFromJson(List<dynamic> rate) {
  List<StepsStat> step = [];
  rate.forEach((element) {
    int k;
    if (element["bool"] == true) {
      k = 100;
    } else {
      k = 10;
    }
    step.add(StepsStat(time: element["time"], value: k));
  });
  return step;
}

List<StepStatMonth> StepStatWeekFromJson(List<dynamic> rate) {
  List<StepStatMonth> heart = [];

  rate.forEach((element) {
    heart.add(StepStatMonth(element["date"], element["value"]));
  });
  return heart;
}
// List<HeartStat>.from(json.decode(str).map((x) => HeartStat.fromJson(x)));

String stepStatToJson(List<StepsStat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StepsStat {
  StepsStat({
    this.time,
    this.value,
  });

  String time;
  int value;

  factory StepsStat.fromJson(Map<String, dynamic> json) => StepsStat(
        time: json["time"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "value": value,
      };
}
