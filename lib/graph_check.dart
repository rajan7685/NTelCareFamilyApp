import 'package:n_tel_care_family_app/landing/landing.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class graphWidget extends StatefulWidget {
  const graphWidget({Key key}) : super(key: key);

  @override
  _WidgetState createState() => _WidgetState();
}

class _WidgetState extends State<graphWidget> {
  /* static final List<BloodStat> stepStat = [
    BloodStat("10:00", 50, Color(0xFF00B89F)),
    BloodStat("11:00", 60, Color(0xFF00B89F)),
    BloodStat("12:00", 50, Color(0xFF00B89F)),
    BloodStat("13:00", 70, Color(0xFF00B89F)),
    BloodStat("14:00", 80, Color(0xFF00B89F)),
    BloodStat("14:00", 80, Color(0xFF00B89F)),
    BloodStat("15:00", 40, Color(0xFF00B89F)),
    BloodStat("16:00", 50, Color(0xFF00B89F)),
    BloodStat("17:00", 80, Color(0xFF00B89F)),
    BloodStat("18:00", 70, Color(0xFF00B89F)),
  ];*/
  static List<charts.Series<BloodStat, String>> _createSampleData() {
    final desktopSalesData = [
      new BloodStat('2014', 5),
      new BloodStat('2015', 25),
      new BloodStat('2016', 100),
      new BloodStat('2017', 75),
    ];

    final tableSalesData = [
      new BloodStat('2014', 25),
      new BloodStat('2015', 50),
      new BloodStat('2016', 10),
      new BloodStat('2017', 20),
    ];

    return [
      new charts.Series<BloodStat, String>(
          id: 'Desktop',
          domainFn: (BloodStat sales, _) => sales.day,
          measureFn: (BloodStat sales, _) => sales.Stat,
          data: desktopSalesData,
          colorFn: (_, __) => charts.Color.fromHex(code: "#00B89F"),
          labelAccessorFn: (BloodStat sales, _) =>
              '\$${sales.Stat.toString()}'),
      new charts.Series<BloodStat, String>(
          id: 'Tablet',
          domainFn: (BloodStat sales, _) => sales.day,
          measureFn: (BloodStat sales, _) => sales.Stat,
          data: tableSalesData,
          colorFn: (_, __) => charts.Color.fromHex(code: "#272E36"),
          labelAccessorFn: (BloodStat sales, _) =>
              '\$${sales.Stat.toString()}'),
    ];
  }

  final List<charts.Series<BloodStat, String>> seriesList = _createSampleData();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var color1 = Color(0xFF00B89F);
  var color2 = Color(0xFF1A1A1A);
  var color3 = Color(0xFF1A1A1A);
  DateTime dateTime;
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
                      'assets/images/blood.svg',
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
                            'Blood-Pressure',
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
                              seriesList,
                              animate: true,
                              defaultRenderer: new charts.BarRendererConfig(
                                  groupingType: charts.BarGroupingType.stacked,
                                  strokeWidthPx: 0.5,
                                  maxBarWidthPx: 10),
                            )
                            //barGroupingType:  charts.BarGroupingType.stacked, strokeWidthPx: 2.0)),
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

class BloodStat {
  final String day;
  final int Stat;

  BloodStat(this.day, this.Stat);
}
