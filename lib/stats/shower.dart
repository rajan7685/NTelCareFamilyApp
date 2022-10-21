// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:dio/dio.dart';
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

class ShowerWidget extends StatefulWidget {
  String data;
  ShowerWidget({Key key, @required this.data}) : super(key: key);

  @override
  _ShowerWidgetState createState() => _ShowerWidgetState(data);
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

List<dynamic> _bathData = [];
bool _isBathDataLoading = true;

class _ShowerWidgetState extends State<ShowerWidget> {
  @override
  void initState() {
    super.initState();
    getStepscount();
    getStepWeekRate();
    getStepMonthlyRate();
    getStepYearlyRate();
    _loadBathData(DateTime.now(), init: true);
  }

  Future<void> _loadBathData(DateTime date, {bool init = false}) async {
    if (!init)
      setState(() {
        _isBathDataLoading = true;
      });
    String uri =
        "${ApiService.domain}/table/sensors?sensor_name=BathRoom&senior_id=${widget.data}&date=${DateFormat('yyyy-MM-dd').format(date)}";
    Response res = await Dio().get(uri);
    _bathData = res.data["data"];
    setState(() {
      _isBathDataLoading = false;
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
  List<ShowerStatMax> stepMin = [];
  List<StepStatMonth> stepMaxMon = [];
  List<ShowerStatMax> stepMinMon = [];
  List<ShowerStatMax> stepMinYr = [];
  List<ShowerStatMax> stepMaxYr = [];
  GetHrate getHrate = GetHrate();
  String id;
  String wDate = DateFormat('yyyy-MM-dd').format(dateTimeWeek);
  String wDate1 = DateFormat('yyyy-MM-dd').format(dateTimeMonth);
  String wDate2 = DateFormat('yyyy-MM-dd').format(dateTimeYear);

  Future<dynamic> Stepcount;
  List<ShowerStat> stepStat = [];

  _ShowerWidgetState(this.id);

  void getStepscount() async {
    String date = DateFormat('yyyy-MM-dd').format(dateTime);
    var response = await getHrate.get(
        '${ApiService.domain}/graph/health_status/?senior_id=${id}&date=${date}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));

    List<ShowerStat> temp =
        stepsStatFromJson(rate["health_status"][0]["BathRoom"]);
    setState(() {
      stepStat = temp;
    });
    print(stepStat);
  }

  List<charts.Series<StepStatMonth, String>> _createSampleData() {
    return [
      new charts.Series<StepStatMonth, String>(
          id: 'max3',
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
          id: 'max2',
          domainFn: (StepStatMonth sales, _) => sales.day,
          measureFn: (StepStatMonth sales, _) => sales.Stat,
          data: stepMaxMon,
          colorFn: (_, __) => charts.Color.fromHex(code: "#00B89F"),
          labelAccessorFn: (StepStatMonth sales, _) =>
              '\$${sales.Stat.toString()}')
    ];
  }

  List<charts.Series<ShowerStatMax, String>> _createSampleDataYear() {
    return [
      new charts.Series<ShowerStatMax, String>(
          id: 'max1',
          domainFn: (ShowerStatMax sales, _) => sales.day,
          measureFn: (ShowerStatMax sales, _) => sales.Stat,
          data: stepMaxYr,
          colorFn: (_, __) => charts.Color.fromHex(code: "#00B89F"),
          labelAccessorFn: (ShowerStatMax sales, _) =>
              '\$${sales.Stat.toString()}'),
      new charts.Series<ShowerStatMax, String>(
          id: 'min1',
          domainFn: (ShowerStatMax sales, _) => sales.day,
          measureFn: (ShowerStatMax sales, _) => sales.Stat,
          data: stepMinYr,
          colorFn: (_, __) => charts.Color.fromHex(code: "#272E36"),
          labelAccessorFn: (ShowerStatMax sales, _) =>
              '\$${sales.Stat.toString()}'),
    ];
  }

//final List<charts.Series<HeartStatWeekMax, String>> seriesList = _createSampleData();

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
                    'Value :' + datumPair.datum.Stat.toString(),
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

  void getStepWeekRate() async {
    wDate = DateFormat('yyyy-MM-dd').format(dateTimeWeek);
    print(wDate);
    var response = await getHrate.get(
        '${ApiService.domain}/graph/health_status/BathRoom/weekly?date=${wDate}&senior_id=${id}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    print(rate["BathRoom"]);
    List<StepStatMonth> temp = StepStatWeekFromJson(rate["BathRoom"]);
    setState(() {
      stepMax = temp;
    });
  }

  void getStepMonthlyRate() async {
    wDate1 = DateFormat('yyyy-MM-dd').format(dateTimeMonth);

    var response = await getHrate.get(
        '${ApiService.domain}/graph/health_status/BathRoom/monthly?date=${wDate1}&senior_id=${id}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    print(rate["BathRoom"]);
    List<StepStatMonth> temp = StepStatWeekFromJson(rate["BathRoom"]);
    setState(() {
      stepMaxMon = temp;
    });
  }

  void getStepYearlyRate() async {
    wDate2 = DateFormat('yyyy-MM-dd').format(dateTimeYear);
    print(wDate2);
    var response = await getHrate.get(
        '${ApiService.domain}/graph/health_status/BathRoom/yearly?date=${wDate2}&senior_id=${id}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    print(rate["BathRoom"]);
    List<ShowerStatMax> temp = StepStatWeekMaxFromJson(rate["BathRoom"]);
    setState(() {
      stepMaxYr = temp;
    });
    List<ShowerStatMax> temp1 = StepStatWeekMinFromJson(rate["BathRoom"]);
    setState(() {
      stepMinYr = temp1;
    });
  }

  var color1 = Color(0xFF00B89F);
  var color2 = Color(0xFF1A1A1A);
  var color3 = Color(0xFF1A1A1A);
  var color4 = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ShowerStat, String>> _createSampleDataDaily() {
      return [
        new charts.Series<ShowerStat, String>(
            id: 'daily2',
            domainFn: (ShowerStat sales, _) => sales.time.toString(),
            measureFn: (ShowerStat sales, _) => sales.value,
            data: stepStat,
            colorFn: (_, __) => charts.Color.fromHex(code: "#00B89F"),
            labelAccessorFn: (ShowerStat sales, _) =>
                '\$${sales.value.toString()}'),
      ];
    }

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
                      Image.asset(
                        'assets/images/corrected_bath.png',
                        width: 220,
                        height: 220,
                        fit: BoxFit.fitWidth,
                      )
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
                              'Shower Sensor',
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
                                    _loadBathData(dateTime);
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

                                  getStepWeekRate();
                                } else if (monthly == true) {
                                  dateTimeMonth = dateTimeMonth
                                      .subtract(Duration(days: 30));
                                  setState(() {
                                    startDateMonth = startDateMonth
                                        .subtract(Duration(days: 30));
                                    endDateMonth = dateTimeMonth;
                                  });
                                  getStepMonthlyRate();
                                } else if (yearly == true) {
                                  dateTimeYear = dateTimeYear
                                      .subtract(Duration(days: 365));
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
                                      : DateFormat('dd-MM-yyyy')
                                          .format(dateTime),
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
                                      dateTime =
                                          dateTime.add(Duration(days: 1));
                                      getStepscount();
                                      _loadBathData(dateTime);
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: Text(
                              'Opened',
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
                              // child: charts.BarChart(
                              //   _createSampleDataDaily(),
                              //   domainAxis: new charts.OrdinalAxisSpec(
                              //       renderSpec:
                              //           new charts.SmallTickRendererSpec(
                              //     labelStyle: new charts.TextStyleSpec(
                              //         fontSize: 6, // size in Pts.
                              //         color: charts.MaterialPalette.white),
                              //   )),
                              // ),

                              child: !_isBathDataLoading
                                  ? SingleChildScrollView(
                                      child: Table(
                                        //textDirection: TextDirection.,
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.top,
                                        // defaultColumnWidth: FixedColumnWidth(120),

                                        border: TableBorder.all(
                                          width: 2.0,
                                          color: Color(0xFF272E36),
                                        ),
                                        children: [
                                          TableRow(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  "Time",
                                                  // textScaleFactor: 1.5,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color(0xFF00B89F),
                                                      fontFamily: 'Montserrat'),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  "Shower Sensor",
                                                  // textScaleFactor: 1.5,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color(0xFF00B89F),
                                                      fontFamily: 'Montserrat'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (_bathData.length == 0)
                                            TableRow(children: [
                                              Text(
                                                "No data",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text("available",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white))
                                            ]),
                                          if (!_isBathDataLoading &&
                                              _bathData.length != 0)
                                            ...List.generate(
                                              _bathData.length,
                                              (index) => TableRow(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Text(
                                                      DateFormat("h:mm a")
                                                          .format(DateTime.parse(
                                                                  "${dateTime.toString().split(" ")[0]} ${_bathData[index]["time"]}Z")
                                                              .toLocal()),
                                                      // textScaleFactor: 1.5,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFAFAFAF),
                                                          fontFamily:
                                                              'Montserrat'),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Text(
                                                      _bathData[index]["value"]
                                                          ? "Accessed"
                                                          : "nil",
                                                      // textScaleFactor: 1.5,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFFAFAFAF),
                                                          fontFamily:
                                                              'Montserrat'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          // TableRow(
                                          //   children: [
                                          //     Padding(
                                          //       padding: EdgeInsets.all(10.0),
                                          //       child: Text(
                                          //         "04-Oct-2022",
                                          //         textAlign: TextAlign.center,
                                          //         // textScaleFactor: 1.5,
                                          //         style: TextStyle(
                                          //             color: Color(0xFFAFAFAF),
                                          //             fontFamily: 'Montserrat'),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding: EdgeInsets.all(10.0),
                                          //       child: Text(
                                          //         "Bathed",
                                          //         // textScaleFactor: 1.5,
                                          //         textAlign: TextAlign.center,
                                          //         style: TextStyle(
                                          //             color: Color(0xFFAFAFAF),
                                          //             fontFamily: 'Montserrat'),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // TableRow(
                                          //   children: [
                                          //     Padding(
                                          //       padding: EdgeInsets.all(10.0),
                                          //       child: Text(
                                          //         "05-Oct-2022",
                                          //         textAlign: TextAlign.center,
                                          //         // textScaleFactor: 1.5,
                                          //         style: TextStyle(
                                          //             color: Color(0xFFAFAFAF),
                                          //             fontFamily: 'Montserrat'),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding: EdgeInsets.all(10.0),
                                          //       child: Text(
                                          //         "Bathed",
                                          //         // textScaleFactor: 1.5,
                                          //         textAlign: TextAlign.center,
                                          //         style: TextStyle(
                                          //             color: Color(0xFFAFAFAF),
                                          //             fontFamily: 'Montserrat'),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                          // TableRow(
                                          //   children: [
                                          //     Padding(
                                          //       padding: EdgeInsets.all(10.0),
                                          //       child: Text(
                                          //         "06-Oct-2022",
                                          //         textAlign: TextAlign.center,
                                          //         // textScaleFactor: 1.5,
                                          //         style: TextStyle(
                                          //             color: Color(0xFFAFAFAF),
                                          //             fontFamily: 'Montserrat'),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //       padding: EdgeInsets.all(10.0),
                                          //       child: Text(
                                          //         "Bathed",
                                          //         // textScaleFactor: 1.5,
                                          //         textAlign: TextAlign.center,
                                          //         style: TextStyle(
                                          //             color: Color(0xFFAFAFAF),
                                          //             fontFamily: 'Montserrat'),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(),
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
                              ),
                            ))
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

List<ShowerStatMax> StepStatWeekMinFromJson(List<dynamic> rate) {
  List<ShowerStatMax> heart = [];

  rate.forEach((element) {
    heart.add(ShowerStatMax(element["date"], element["min"], element["avg"],
        element["max"], element["min"]));
  });
  return heart;
}

List<ShowerStatMax> StepStatWeekMaxFromJson(List<dynamic> rate) {
  List<ShowerStatMax> heart = [];

  rate.forEach((element) {
    heart.add(ShowerStatMax(element["date"], element["max_min"], element["avg"],
        element["max"], element["min"]));
  });
  return heart;
}

class StepStatMonth {
  final String day;
  final int Stat;

  StepStatMonth(this.day, this.Stat);
}

List<StepStatMonth> StepStatWeekFromJson(List<dynamic> rate) {
  List<StepStatMonth> heart = [];

  rate.forEach((element) {
    heart.add(StepStatMonth(element["date"], element["value"]));
  });
  return heart;
}

class ShowerStatMax {
  final String day;
  final int Stat;
  final int avg;
  final int max;
  final int min;

  ShowerStatMax(this.day, this.Stat, this.avg, this.max, this.min);
}

List<ShowerStat> stepsStatFromJson(List<dynamic> rate) {
  List<ShowerStat> step = [];
  rate.forEach((element) {
    print(element);
    int k;
    if (element["value"] == true) {
      k = 100;
    } else {
      k = 0;
    }
    step.add(ShowerStat(time: element["time"], value: k));
  });
  return step;
}
// List<HeartStat>.from(json.decode(str).map((x) => HeartStat.fromJson(x)));

String stepStatToJson(List<ShowerStat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowerStat {
  ShowerStat({
    this.time,
    this.value,
  });

  int time;
  int value;

  factory ShowerStat.fromJson(Map<String, dynamic> json) => ShowerStat(
        time: json["time"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "value": value,
      };
}
