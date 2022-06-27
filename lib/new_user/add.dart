import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:n_tel_care_family_app/critical/critical_widget.dart';
import 'package:n_tel_care_family_app/members/members.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Add extends StatefulWidget {
  const Add({Key key}) : super(key: key);

  @override
  _AddWidgetState createState() => _AddWidgetState();
}

class _AddWidgetState extends State<Add> {
  String dropDownValue;
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  bool switchListTileValue;
  bool checkboxListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var color1 = Color(0xFF00B89F);
  var color2 = Color(0xFFD6D6D6);
  var color = Color(0xFFD6D6D6);
  var colorA = Color(0xFFD6D6D6);
  var colorB = Color(0xFFD6D6D6);
  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: 'Kenny');
    textController2 = TextEditingController(text: 'Alter');
    textController3 = TextEditingController(text: '967583222');
  }

  bool display = false;
  bool displayY = true;
  bool displayN = false;
  bool displayLive = false;
  bool displayChat = false;
  bool displayView = false;
  File image;
  Future<File> savePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name1 = basename(imagePath);
    final image2 = File('${directory.path}/$name1');
    return File(imagePath).copy(image2.path);
  }

  Future pickimage(ImageSource source1) async {
    try {
      final image = await ImagePicker().pickImage(source: source1);
      if (image == Null) {
        return Null;
      }
      // final imagePath = File(image.path);
      final imagePathPermanently = await savePermanently(image.path);
      setState(() => this.image = imagePathPermanently);
      setState(() {
        display = false;
      });
    } on PlatformException catch (e) {
      print("Permission Denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF1F252B),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            // Customize what your widget looks like when it's loading.
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                              Navigator.pop(context);
                              /* await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MembersWidget(),
                                ),
                              );*/
                            },
                            child: Icon(
                              Icons.chevron_left_sharp,
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              size: 35,
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
                                Align(
                                  alignment: AlignmentDirectional(0.05, -0.43),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        17, 0, 0, 0),
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF006B5D),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '5',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 10),
                        child: Text(
                          'Add',
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFAFAFAF),
                                    fontSize: 42,
                                    fontWeight: FontWeight.w200,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 45, 0, 0),
                        child: Container(
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                            child: TextFormField(
                              controller: textController1,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'First Name',
                                hintText: '[Some hint text...]',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: TextFormField(
                              controller: textController2,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                                hintText: '[Some hint text...]',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: TextFormField(
                              controller: textController3,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                hintText: '[Some hint text...]',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 8,
                                child: DropdownButtonFormField(
                                  value: dropDownValue,
                                  items: [
                                    "Son",
                                    "Daughter",
                                    "Grand Son",
                                    "Grand Daugter"
                                  ]
                                      .map((label) => DropdownMenuItem(
                                            child: Text(label),
                                            value: label,
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() => dropDownValue = value);
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                      ),
                                  hint: Text('Enter relationship'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFF323A43),
                                  shape: BoxShape.circle,
                                ),
                                child: Stack(
                                  children: [
                                    if (image == null)
                                      SvgPicture.asset(
                                        'assets/images/man.svg',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    else
                                      //Image.asset(Image.file(image!),width: 100,height: 100,fit: BoxFit.cover)
                                      ClipOval(
                                          child: Image.file(
                                        image,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(1.34, 0.97),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF00B89F),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    if (display == displayN) {
                                                      display = displayY;
                                                    } else {
                                                      display = displayN;
                                                    }
                                                  });
                                                },
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/images/camera.svg',
                                                      height: 20,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
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
                      if (display ?? true)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFECFFFC),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          45, 0, 0, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          pickimage(ImageSource.camera);
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF00B89F),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/camera.svg',
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 2, 0, 0),
                                                  child: Text(
                                                    'Camera',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF1F252B),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 45, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        pickimage(ImageSource.gallery);
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF00B89F),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/_icons.svg',
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 2, 0, 0),
                                                child: Text(
                                                  'Gallery',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF1F252B),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      /* Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Color(0xFF323A43),
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/Layer 2.svg',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(1.34, 0.97),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF00B89F),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/camera.svg',
                                                  height: 18,
                                                  fit: BoxFit.cover,
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
                          ),
                        ],
                      ),*/
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 8, 0, 0),
                              child: SwitchListTile(
                                value: FFAppState().Chattoggle5,
                                onChanged: (bool value) => setState(
                                    () => FFAppState().Chattoggle5 = value),
                                title: Text(
                                  'Executive Members',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFFE5E5E5),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w200,
                                      ),
                                ),
                                tileColor: Color(0xFF1F252B),
                                activeColor: Color(0xB254DCC5),
                                activeTrackColor: Color(0xFF00B89F),
                                dense: false,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Color(0xFF23ECB9),
                        ),
                        child: CheckboxListTile(
                          value: checkboxListTileValue ??= true,
                          onChanged: (newValue) =>
                              setState(() => checkboxListTileValue = newValue),
                          title: Text(
                            'Enable live view',
                            style: FlutterFlowTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFE5E5E5),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                          tileColor: Color(0xFF1F252B),
                          activeColor: Color(0xFF23ECB9),
                          checkColor: Color(0xFF1F252B),
                          dense: false,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      if (FFAppState().Chattoggle5 ?? true)
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        'Permissions',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFFAFAFAF),
                                              fontSize: 30,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15, 25, 15, 55),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF292929),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: color,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 1, 10, 1),
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              if (color == color1) {
                                                color = color2;
                                                displayLive = false;
                                              } else {
                                                color = color1;
                                                displayLive = true;
                                              }
                                            });
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 2),
                                                child: Icon(
                                                  Icons.videocam_outlined,
                                                  color: Color(0xB254DCC5),
                                                  size: 22,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 0, 0, 0),
                                                child: Text(
                                                  'Live Video',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: color,
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                  Container(
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF292929),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: colorA,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          setState(() {
                                            if (colorA == color1) {
                                              colorA = color2;
                                              displayView = false;
                                            } else {
                                              colorA = color1;
                                              displayView = true;
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 1, 10, 1),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/2006462_google_media_play_video_icon.svg',
                                                width: 15,
                                                height: 15,
                                                fit: BoxFit.cover,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 0, 0, 0),
                                                child: Text(
                                                  'View Video',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: colorA,
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF292929),
                                      borderRadius: BorderRadius.circular(5),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: colorB,
                                      ),
                                    ),
                                    alignment: AlignmentDirectional(
                                        0.1499999999999999, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        setState(() {
                                          if (colorB == color1) {
                                            colorB = color2;
                                            displayChat = false;
                                          } else {
                                            colorB = color1;
                                            displayChat = true;
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 1, 10, 1),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/353430_checkbox_pen_edit_pencil_icon.svg',
                                              width: 13,
                                              fit: BoxFit.cover,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 0, 0, 0),
                                              child: Text(
                                                'Chat',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: colorB,
                                                          fontSize: 12,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            // await Navigator.push(
                            //  context,
                            // MaterialPageRoute(
                            //  builder: (context) =>
                            //   NavBarPage(initialPage: 'Landing'),
                            //  ),
                            // );
                            if (textController1.text == "" ||
                                textController2.text == "" ||
                                textController3.text == "" ||
                                dropDownValue == null ||
                                image == null) {
                              Fluttertoast.showToast(
                                  msg: "All fields are necessary to fill",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 5,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.black,
                                  fontSize: 14.0);
                            } else {
                              final String url =
                                  "http://18.208.148.208:4000/add/member";
                              /* final res =
                                  await http.post(Uri.parse(url), body: {
                                "fname": textController1.text,
                                "lname": textController2.text,
                                "email": "priya@gmail.com",
                                "mobile": textController3.text,
                                "relation": dropDownValue,
                                "executive": "display",
                                "m_acc_id": FFAppState().AccountId,
                                "password": "123456",
                                "confirm_password": "123456",
                                "address": "123456",
                                "zipcode": "123456",
                                "live_video": "displayLive",
                                "chats": "displayChat",
                                "view_video": "displayView",
                              });*/
                              /*   var stream =
                                  new http.ByteStream(image.openRead());
                              stream.cast();
                              var length = await image.length();*/

                              var res1 = new http.MultipartRequest(
                                  'POST', Uri.parse(url));
                              res1.headers.addAll({
                                'Authorization': 'Bearer ${FFAppState().Token}'
                              });
                              res1.fields['fname'] = textController1.text;
                              res1.fields['lname'] = textController2.text;
                              res1.fields['email'] = "priya@gmail.com";
                              res1.fields['mobile'] = textController3.text;
                              res1.fields['relation'] = dropDownValue;
                              res1.fields['executive'] = "display";
                              res1.fields['m_acc_id'] = FFAppState().AccountId;
                              res1.fields['password'] = "123456";
                              res1.fields['confirm_password'] = "123456";
                              res1.fields['address'] = "123456";
                              res1.fields['zipcode'] = "123456";
                              res1.fields['live_video'] = "123456";
                              res1.fields['chats'] = "123456";
                              res1.fields['view_video'] = "123456";
                              //// var multiport = new http.MultipartFile(
                              // 'profile', stream, length);
                              res1.files.add(http.MultipartFile.fromString(
                                  'profile', image.path));
                              var response = await res1.send();
                              // final result = jsonDecode(res.body);
                              // print(data?.jsonBody[0].runtimeType);

                              //if ((getJsonField(
                              //  (data?.jsonBody ?? ''),
                              //  r'''$[:].Error''',
                              //)) ==
                              // ('Nill'))

                              print("this is the status code");
                              print(response.statusCode);
                              final respStr =
                                  await response.stream.bytesToString();
                              // final result = jsonDecode(res.body);
                              if (response.statusCode == 200) {
                                print("uploaded");

                                Fluttertoast.showToast(
                                    msg: "uploaded",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.black,
                                    fontSize: 14.0);
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content:
                                          Text(jsonDecode(respStr)["message"]),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                            // setState(() {});
                          },
                          text: 'Save',
                          options: FFButtonOptions(
                            width: 350,
                            height: 40,
                            color: Color(0xFF00B89F),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 30),
                        child: FFButtonWidget(
                          onPressed: () {
                            print("on pressesd");
                          },
                          text: 'Delete User',
                          options: FFButtonOptions(
                            width: 350,
                            height: 40,
                            color: FlutterFlowTheme.of(context).alternate,
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
