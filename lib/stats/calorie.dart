import 'dart:convert';

import 'package:n_tel_care_family_app/backend/ApiService.dart';
import 'package:n_tel_care_family_app/backend/api_requests/api_calls.dart';
import 'package:n_tel_care_family_app/landing/landing.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CalorieWidget extends StatefulWidget {
  String data;
  CalorieWidget({Key key, @required this.data}) : super(key: key);

  @override
  _CalorieWidgetState createState() => _CalorieWidgetState(data);
}

class _CalorieWidgetState extends State<CalorieWidget> {
  Future<dynamic> calories;
  List<CalorieStat> calorie = [];
  GetCalories getCalories = GetCalories();
  static final List<CalorieStat> calorieStat = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var color1 = Color(0xFF00B89F);
  var color2 = Color(0xFF1A1A1A);
  var color3 = Color(0xFF1A1A1A);
  DateTime dateTime;
  String id;
  _CalorieWidgetState(this.id);

  @override
  void initState() {
    super.initState();
    getCalori();
    // int versionCode = BuildConfig.VERSION_CODE;
    // HeartStatus = fetchStat();
  }

  void getCalori() async {
    var response = await getCalories
        .get('${ApiService.domain}/graph/health_status/?senior_id=${id}');
    print(response.statusCode);
    print(response.body.runtimeType);
    print(response.body);
    final rate = jsonDecode((response.body));
    print(rate["health_status"]["heart_rate"].runtimeType);

    List<CalorieStat> temp =
        calorieStatFromJson(rate["health_status"]["heart_rate"]);
    setState(() {
      calorie = temp;
    });
    print(calorie);
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<CalorieStat, String>> calories = [
      charts.Series(
          data: calorie,
          id: "Calorie",
          domainFn: (CalorieStat pops, _) => pops.time,
          measureFn: (CalorieStat pops, _) => pops.value,
          colorFn: (CalorieStat pops, _) =>
              charts.ColorUtil.fromDartColor(Color(0xFF00B89F)))
    ];

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
                      'assets/images/calorie.svg',
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
                            'Calorie',
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
                          )
                        ],
                      ),
                    ),
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
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                              color: Color(0xFF272E36),
                              borderRadius: BorderRadius.circular(10)),
                          child: charts.BarChart(
                            calories,
                            animate: true,
                          ),
                        )),
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

List<CalorieStat> calorieStatFromJson(List<dynamic> rate) {
  List<CalorieStat> heart = [];
  rate.forEach((element) {
    heart.add(CalorieStat.fromJson(element));
  });
  return heart;
}
// List<HeartStat>.from(json.decode(str).map((x) => HeartStat.fromJson(x)));

String calorieStatToJson(List<CalorieStat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CalorieStat {
  CalorieStat({
    this.time,
    this.value,
  });

  String time;
  int value;

  factory CalorieStat.fromJson(Map<String, dynamic> json) => CalorieStat(
        time: json["time"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "value": value,
      };
}
