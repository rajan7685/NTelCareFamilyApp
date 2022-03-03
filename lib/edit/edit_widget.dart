import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditWidget extends StatefulWidget {
  const EditWidget({Key key}) : super(key: key);

  @override
  _EditWidgetState createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  TextEditingController textController4;
  bool checkboxListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: 'Kenny');
    textController2 = TextEditingController(text: 'Alter');
    textController3 = TextEditingController(text: '967583222');
    textController4 = TextEditingController(text: 'prateek@remail.solutions');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(-0.99, 0.29),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF292929),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 315,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00B89F), Color(0xFF005C50)],
                  stops: [0, 1],
                  begin: AlignmentDirectional(0.77, -1),
                  end: AlignmentDirectional(-0.77, 1),
                ),
              ),
            ),
            FutureBuilder<ApiCallResponse>(
              future: LoginCall.call(),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                    ),
                  );
                }
                final columnLoginResponse = snapshot.data;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(7, 45, 10, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NavBarPage(initialPage: 'Profile'),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.chevron_left_sharp,
                                color:
                                    FlutterFlowTheme.of(context).tertiaryColor,
                                size: 35,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Icon(
                              Icons.notifications_none,
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 10),
                          child: Text(
                            'Edit Profile',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryColor,
                                      fontSize: 40,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFF292929),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 45, 0, 0),
                                      child: Container(
                                        width: 350,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 5, 0, 0),
                                          child: TextFormField(
                                            controller: textController1,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'First Name',
                                              hintText: '[Some hint text...]',
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Container(
                                        width: 350,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: TextFormField(
                                            controller: textController2,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Last Name',
                                              hintText: '[Some hint text...]',
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Container(
                                        width: 350,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: TextFormField(
                                            controller: textController3,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Phone Number',
                                              hintText: '[Some hint text...]',
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Container(
                                        width: 350,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: TextFormField(
                                            controller: textController4,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                              hintText: '[Some hint text...]',
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Theme(
                                      data: ThemeData(
                                        unselectedWidgetColor:
                                            Color(0xFF707070),
                                      ),
                                      child: CheckboxListTile(
                                        value: checkboxListTileValue ??= true,
                                        onChanged: (newValue) => setState(() =>
                                            checkboxListTileValue = newValue),
                                        title: Text(
                                          'Enable live view',
                                          style: FlutterFlowTheme.of(context)
                                              .title3
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                        tileColor: Color(0xFFF5F5F5),
                                        dense: false,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    text: 'Save',
                                    options: FFButtonOptions(
                                      width: 350,
                                      height: 40,
                                      color: Color(0xFF00B89F),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 12,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      print('Button pressed ...');
                                    },
                                    text: 'Delete User',
                                    options: FFButtonOptions(
                                      width: 350,
                                      height: 40,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFDF0808),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      borderSide: BorderSide(
                                        color: Color(0xFFDF0808),
                                        width: 1,
                                      ),
                                      borderRadius: 12,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
