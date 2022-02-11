import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DevicesWidget extends StatefulWidget {
  const DevicesWidget({Key key}) : super(key: key);

  @override
  _DevicesWidgetState createState() => _DevicesWidgetState();
}

class _DevicesWidgetState extends State<DevicesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xFF005C50),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFF292929),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Text(
                            'Devices',
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.tertiaryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: FaIcon(
                            FontAwesomeIcons.bell,
                            color: FlutterFlowTheme.tertiaryColor,
                            size: 24,
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
                        height: 300,
                        decoration: BoxDecoration(
                          color: Color(0xFF292929),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 0, 15, 0),
                                        child: ListView(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Container(
                                              height: 75,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF262626),
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons.watch_sharp,
                                                  color: Color(0xFF005C50),
                                                  size: 40,
                                                ),
                                                title: Text(
                                                  'Mi Band',
                                                  style: FlutterFlowTheme.title3
                                                      .override(
                                                    fontFamily: 'Poppins',
                                                    color: FlutterFlowTheme
                                                        .tertiaryColor,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  'Grandpa',
                                                  style: FlutterFlowTheme
                                                      .subtitle2,
                                                ),
                                                tileColor: Color(0xFFF5F5F5),
                                                dense: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 0),
                                              child: Container(
                                                width: 100,
                                                height: 75,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF262626),
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                    'Lorem ipsum dolor...',
                                                    style:
                                                        FlutterFlowTheme.title3,
                                                  ),
                                                  subtitle: Text(
                                                    'Lorem ipsum dolor...',
                                                    style: FlutterFlowTheme
                                                        .subtitle2,
                                                  ),
                                                  trailing: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Color(0xFF303030),
                                                    size: 20,
                                                  ),
                                                  tileColor: Color(0xFFF5F5F5),
                                                  dense: false,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 0),
                                              child: Container(
                                                width: 100,
                                                height: 75,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF262626),
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                    'Lorem ipsum dolor...',
                                                    style:
                                                        FlutterFlowTheme.title3,
                                                  ),
                                                  subtitle: Text(
                                                    'Lorem ipsum dolor...',
                                                    style: FlutterFlowTheme
                                                        .subtitle2,
                                                  ),
                                                  trailing: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Color(0xFF303030),
                                                    size: 20,
                                                  ),
                                                  tileColor: Color(0xFFF5F5F5),
                                                  dense: false,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 0),
                                              child: Container(
                                                width: 100,
                                                height: 75,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF262626),
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                    'Lorem ipsum dolor...',
                                                    style:
                                                        FlutterFlowTheme.title3,
                                                  ),
                                                  subtitle: Text(
                                                    'Lorem ipsum dolor...',
                                                    style: FlutterFlowTheme
                                                        .subtitle2,
                                                  ),
                                                  trailing: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Color(0xFF303030),
                                                    size: 20,
                                                  ),
                                                  tileColor: Color(0xFFF5F5F5),
                                                  dense: false,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 0),
                                              child: Container(
                                                width: 100,
                                                height: 75,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF262626),
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                    'Lorem ipsum dolor...',
                                                    style:
                                                        FlutterFlowTheme.title3,
                                                  ),
                                                  subtitle: Text(
                                                    'Lorem ipsum dolor...',
                                                    style: FlutterFlowTheme
                                                        .subtitle2,
                                                  ),
                                                  trailing: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Color(0xFF303030),
                                                    size: 20,
                                                  ),
                                                  tileColor: Color(0xFFF5F5F5),
                                                  dense: false,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 10, 0, 0),
                                              child: Container(
                                                width: 100,
                                                height: 75,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF262626),
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: ListTile(
                                                  title: Text(
                                                    'Lorem ipsum dolor...',
                                                    style:
                                                        FlutterFlowTheme.title3,
                                                  ),
                                                  subtitle: Text(
                                                    'Lorem ipsum dolor...',
                                                    style: FlutterFlowTheme
                                                        .subtitle2,
                                                  ),
                                                  trailing: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Color(0xFF303030),
                                                    size: 20,
                                                  ),
                                                  tileColor: Color(0xFFF5F5F5),
                                                  dense: false,
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
                            ],
                          ),
                        ),
                      ),
                    ),
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
