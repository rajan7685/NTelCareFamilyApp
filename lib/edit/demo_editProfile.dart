import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:n_tel_care_family_app/backend/ApiService.dart';
import 'package:n_tel_care_family_app/core/shared_preferences_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:n_tel_care_family_app/critical/critical_widget.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class EditCopy2Widget extends StatefulWidget {
  dynamic info;
  List<dynamic> countries;
  EditCopy2Widget({Key key, @required this.info, @required this.countries})
      : super(key: key);

  @override
  _EditCopy2WidgetState createState() => _EditCopy2WidgetState(info);
}

class _EditCopy2WidgetState extends State<EditCopy2Widget> {
  final formKey = GlobalKey<FormState>();
  String dropDownValue;
  String dropDownValueGender;
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  TextEditingController textController4;
  TextEditingController textController6;
  TextEditingController textController7;
  TextEditingController textController8 = TextEditingController();
  TextEditingController textController9 = TextEditingController();
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  String countryCode;
  DateTime selectedDate;

  dynamic placesData;
  bool switchListTileValue;
  bool checkboxListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic info;
  var profile = null;
  bool _isExecutive;
  _EditCopy2WidgetState(this.info);

  var color1 = Color(0xFF00B89F);
  var color2 = Color(0xFFD6D6D6);
  var color = Color(0xFFD6D6D6);
  var colorA = Color(0xFFD6D6D6);
  var colorB = Color(0xFFD6D6D6);
  var selected = "Son";
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

  void vaildMail() {
    final bool isVaild = EmailValidator.validate(textController4.text.trim());
    if (!isVaild) {
      Fluttertoast.showToast(
          msg: "Invaild e-mail address",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 14.0);
    }
  }

  Future pickimage(ImageSource source1) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source1, imageQuality: 50);
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

  Future<void> _loadAddress() async {
    print("calling loadAdrs");
    String uri =
        '${ApiService.domain}/zipcode/${countryCode.toLowerCase()}/${textController7.text}';
    final res = await http.get(
      Uri.parse(uri),
      headers: {
        "Authorization":
            "Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}"
      },
    );

    if (res.statusCode == 200) placesData = jsonDecode(res.body);

    if (res.statusCode == 200 &&
        placesData["data"] != null &&
        placesData["data"]["country_code"] != null) {
      setState(() {
        textController8.text = placesData['data']['state_name'];
        textController9.text = placesData['data']['county_name'];
      });
      dynamic countryValue = widget.countries.singleWhere((element) =>
          element['code'] == placesData['data']['country_code'])['name'];
      cityValue = placesData['data']['county_name'];
      stateValue = placesData['data']['state_name'];
    }
  }

  @override
  void initState() {
    super.initState();
    print("edit profile countries : ${widget.countries}");
    print(info["member"]["fname"]);
    profile = info["member"]["profile"];
    // print(" countrues ${widget.countries}");
    print(" relationships ${FFAppState().relation}");
    print(profile);
    textController1 = TextEditingController(text: info["member"]["fname"]);
    textController2 = TextEditingController(text: info["member"]["lname"]);
    textController3 = TextEditingController(text: info["member"]["mobile"]);
    textController4 = TextEditingController(text: info["member"]["email"]);
    textController6 = TextEditingController(text: info["member"]["address"]);
    textController7 = TextEditingController(text: info["member"]["zipcode"]);
    textController8 = TextEditingController(text: info["member"]["state"]);
    textController9 = TextEditingController(text: info["member"]["city"]);
    FFAppState().executiveToggleProfile = info["member"]["executive"];
    FFAppState().liveView = info["member"]["permission"]["live_video"];
    FFAppState().viewVideo = info["member"]["permission"]["view_video"];
    FFAppState().chat = info["member"]["permission"]["chat"];

    dropDownValueGender = (info["member"]["sex"] as String).capitalize;
    countryCode = info["member"]["ccode"];
    cityValue = info["member"]["city"];
    countryValue = info["member"]["country"];
    stateValue = info["member"]["state"];
    selectedDate = HttpDate.parse(info["member"]["dob"]);
    dropDownValue = (info["member"]["relation"] as String).isEmpty
        ? null
        : info["member"]["relation"];
    _isExecutive = FFAppState().executiveToggleProfile ?? false;
    if (_isExecutive) {
      displayLive = displayChat = displayView = true;
    } else {
      displayLive = FFAppState().liveView;
      displayChat = FFAppState().chat;
      displayView = FFAppState().viewVideo;
    }
  }
  //

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF1F252B),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(7, 63, 10, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: InkWell(
                              onTap: () async {
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
                                  // Align(
                                  //   alignment:
                                  //       AlignmentDirectional(0.05, -0.43),
                                  //   child: Padding(
                                  //     padding: EdgeInsetsDirectional.fromSTEB(
                                  //         17, 0, 0, 0),
                                  //     child: Container(
                                  //       width: 15,
                                  //       height: 15,
                                  //       decoration: BoxDecoration(
                                  //         color: Color(0xFF006B5D),
                                  //         shape: BoxShape.circle,
                                  //       ),
                                  //       child: Row(
                                  //         mainAxisSize: MainAxisSize.max,
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.center,
                                  //         children: [
                                  //           Text(
                                  //             '5',
                                  //             style: FlutterFlowTheme.of(
                                  //                     context)
                                  //                 .bodyText1
                                  //                 .override(
                                  //                   fontFamily: 'Montserrat',
                                  //                   color: Colors.white,
                                  //                   fontSize: 8,
                                  //                   fontWeight: FontWeight.bold,
                                  //                 ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
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
                          padding:
                              EdgeInsetsDirectional.fromSTEB(15, 10, 0, 10),
                          child: Text(
                            'Edit Profile',
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
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 35, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 5, 0, 0),
                                  child: TextFormField(
                                    controller: textController1,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'First Name',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF9A9A9A),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
                                      hintText: 'Enter First Name',
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
                                          color: Color(0xFF606E87),
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: TextFormField(
                                    controller: textController2,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Last Name',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF9A9A9A),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
                                      hintText: 'Enter Last Name',
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
                                          color: Color(0xFF606E87),
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .44,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEEEEEE),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child:
                                              DropdownButtonFormField<String>(
                                            value:
                                                dropDownValueGender.capitalize,
                                            items: [
                                              "Male",
                                              "Female",
                                              "Transgender",
                                              "Other"
                                            ]
                                                .map(
                                                    (label) => DropdownMenuItem(
                                                          child: Text(label),
                                                          value: label,
                                                        ))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() =>
                                                  dropDownValueGender = value);
                                            },
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              filled: true,
                                              fillColor: Color(0xFFEEEEEE),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFF606E87),
                                                ),
                                            hint: Text('Gender'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .44,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEEEEEE),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 10, 0, 3),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'DOB',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Color(
                                                                0xFF9A9A9A),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 0),
                                                    child: Text(
                                                        DateFormat('MM-dd-yyyy')
                                                            .format(
                                                                selectedDate),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: Color(
                                                                      0xFF606E87),
                                                                  fontSize: 16,
                                                                )),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: InkWell(
                                            onTap: () async {
                                              final DateTime picked =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: selectedDate,
                                                      firstDate:
                                                          DateTime(1948, 8),
                                                      lastDate: DateTime.now());
                                              if (picked != null &&
                                                  picked != selectedDate)
                                                setState(() {
                                                  selectedDate = picked;
                                                });
                                            },
                                            child: Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: TextFormField(
                                      controller: textController4,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF9A9A9A),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                        hintText: "Enter E-mail Address",
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
                                            color: Color(0xFF606E87),
                                            fontSize: 16,
                                          ),
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (_) =>
                                          formKey.currentState.validate(),
                                      validator: (value) {
                                        if (EmailValidator.validate(value))
                                          return 'error';
                                        return null;
                                      }),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: TextFormField(
                                    controller: textController3,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF9A9A9A),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
                                      hintText: 'Enter Phone Number',
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
                                          color: Color(0xFF606E87),
                                          fontSize: 16,
                                        ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      MaskedInputFormatter('###.###.####')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: DropdownButtonFormField<dynamic>(
                                        isExpanded: true,
                                        value: countryCode,
                                        items: widget.countries
                                            .map((label) => DropdownMenuItem(
                                                  child: Text(label['name']),
                                                  value: label['code'],
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            print(value);
                                            String abc = widget.countries
                                                .firstWhere((element) =>
                                                    element['code'] ==
                                                    value)['name'];
                                            setState(() {
                                              print(
                                                  " value of country : $value");
                                              countryCode = value;
                                              countryValue = abc;
                                            });
                                          });
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFEEEEEE),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF606E87),
                                            ),
                                        hint: Text('Country'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: TextFormField(
                                    controller: textController7,
                                    obscureText: false,
                                    onChanged: (_) => _loadAddress(),
                                    decoration: InputDecoration(
                                      labelText: 'Zip Code',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF9A9A9A),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
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
                                          color: Color(0xFF606E87),
                                          fontSize: 16,
                                        ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      controller: textController8,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'State',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF9A9A9A),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
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
                                            color: Color(0xFF606E87),
                                            fontSize: 16,
                                          ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      controller: textController9,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'City',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xFF9A9A9A),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
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
                                            color: Color(0xFF606E87),
                                            fontSize: 16,
                                          ),
                                      keyboardType: TextInputType.streetAddress,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: TextFormField(
                                    controller: textController6,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Address',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF9A9A9A),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
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
                                          color: Color(0xFF606E87),
                                          fontSize: 16,
                                        ),
                                    keyboardType: TextInputType.streetAddress,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Container(
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
                                        items: FFAppState()
                                            .relation
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFEEEEEE),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF606E87),
                                            ),
                                        hint: Text('Enter relationship'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
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
                                            ClipOval(
                                                child: Image.network(
                                              profile ??
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYL2_7f_QDJhq5m9FYGrz5W4QI5EUuDLSdGA&usqp=CAU",
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ))
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
                                            alignment: AlignmentDirectional(
                                                1.34, 0.97),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF00B89F),
                                                shape: BoxShape.circle,
                                              ),
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () async {
                                                        setState(() {
                                                          if (display ==
                                                              displayN) {
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
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
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
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 2, 0, 0),
                                                        child: Text(
                                                          'Camera',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                color: Color(
                                                                    0xFF1F252B),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 2, 0, 0),
                                                      child: Text(
                                                        'Gallery',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Montserrat',
                                                                  color: Color(
                                                                      0xFF1F252B),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 0),
                                    child: SwitchListTile(
                                      value:
                                          FFAppState().executiveToggleProfile,
                                      onChanged: (bool value) {
                                        // do nothing
                                      },
                                      title: Text(
                                        'Executive Member',
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
                                unselectedWidgetColor: Color(0xFF707070),
                              ),
                              child: CheckboxListTile(
                                value: checkboxListTileValue ??= true,
                                onChanged: (newValue) => setState(
                                    () => checkboxListTileValue = newValue),
                                title: Text(
                                  'Enable live view',
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFFE5E5E5),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                      ),
                                ),
                                tileColor: Color(0xFF1F252B),
                                activeColor: Color(0xD323ECB9),
                                dense: false,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 10),
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
                                      15, 5, 15, 30),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF292929),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color:
                                                  displayLive ? color1 : color2,
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              /*if (!_isExecutive) {
                                                setState(() {
                                                  displayLive = !displayLive;
                                                });
                                              }*/
                                            },
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 1, 10, 1),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 2),
                                                    child: Icon(
                                                      Icons.videocam_outlined,
                                                      color: Color(0xB254DCC5),
                                                      size: 22,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 0, 0, 0),
                                                    child: Text(
                                                      'Live Video',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: displayLive
                                                                ? color1
                                                                : color2,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color:
                                                  displayView ? color1 : color2,
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              /*setState(() {
                                                if (!_isExecutive) {
                                                  setState(() {
                                                    displayView = !displayView;
                                                  });
                                                }
                                              });*/
                                            },
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 1, 10, 1),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/2006462_google_media_play_video_icon.svg',
                                                    width: 15,
                                                    height: 15,
                                                    color: color1,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 0, 0, 0),
                                                    child: Text(
                                                      'View Video',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: displayView
                                                                ? color1
                                                                : color2,
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color:
                                                displayChat ? color1 : color2,
                                          ),
                                        ),
                                        alignment: AlignmentDirectional(
                                            0.1499999999999999, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            /*setState(() {
                                              if (!_isExecutive) {
                                                setState(() {
                                                  displayChat = !displayChat;
                                                });
                                              }
                                            });*/
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
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
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: displayChat
                                                              ? color1
                                                              : color2,
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 30),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  //final form = formKey.currentState;
                                  print('invoking method');
                                  if (textController1.text == "" ||
                                      textController2.text == "" ||
                                      textController3.text == "" ||
                                      textController4.text == "" ||
                                      textController6.text == "" ||
                                      textController7.text == "" ||
                                      dropDownValueGender == "" ||
                                      dropDownValue == null) {
                                    // print('invoking method');
                                    Fluttertoast.showToast(
                                        msg: "All fields are necessary to fill",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.black,
                                        fontSize: 14.0);
                                  } else {
                                    // List<int> imagebytes = image.readAsBytesSync();
                                    // String base64Image = base64Encode(imagebytes);
                                    // print(base64Image);
                                    FFAppState().executive =
                                        FFAppState().executiveToggleProfile;
                                    final String url =
                                        "${ApiService.domain}/edit/profile/member";
                                    var res = new http.MultipartRequest(
                                        'POST', Uri.parse(url));

                                    res.headers['Authorization'] =
                                        "Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}";

                                    res.fields["fname"] = textController1.text;
                                    res.fields["lname"] = textController2.text;
                                    res.fields["mobile"] = textController3.text
                                        .replaceAll(".", "");
                                    res.fields["email"] = textController4.text;
                                    res.fields["relation"] = dropDownValue;
                                    res.fields["address"] =
                                        textController6.text;
                                    res.fields["zipcode"] =
                                        textController7.text;
                                    res.fields["live_video"] =
                                        displayLive.toString();
                                    res.fields["chat"] = displayChat.toString();
                                    res.fields["view_video"] =
                                        displayView.toString();
                                    res.fields["executive"] = FFAppState()
                                        .executiveToggleProfile
                                        .toString();
                                    res.fields["country"] = countryValue;
                                    ;
                                    res.fields["state"] = textController8.text;
                                    res.fields["city"] = textController9.text;
                                    res.fields["gender"] = dropDownValueGender;
                                    res.fields["dob"] = DateFormat("yyyy-MM-dd")
                                        .format(selectedDate);
                                    res.fields["age"] = "68"; // make dynamic

                                    /*  profile == null
                                    ? res.files.add(
                                        await http.MultipartFile.fromPath(
                                            "profile", image.path))
                                    : res.files.add(http.MultipartFile.fromString(
                                        "profile", profile));
                    */
                                    // profile valiation
                                    if (profile != null) {
                                      final http.Response responseData =
                                          await http.get(Uri.parse(profile));
                                      Uint8List uint8list =
                                          responseData.bodyBytes;
                                      var buffer = uint8list.buffer;
                                      ByteData byteData = ByteData.view(buffer);
                                      var tempDir =
                                          await getTemporaryDirectory();
                                      File file =
                                          await File('${tempDir.path}/img')
                                              .writeAsBytes(buffer.asUint8List(
                                                  byteData.offsetInBytes,
                                                  byteData.lengthInBytes));
                                      print(file.path);
                                      image == null
                                          ? res.files.add(
                                              await http.MultipartFile.fromPath(
                                                  "profile", file.path))
                                          : res.files.add(
                                              await http.MultipartFile.fromPath(
                                                  "profile", image.path));
                                    }
                                    var response = await res.send();

                                    print(response.statusCode);
                                    final resp =
                                        await response.stream.bytesToString();
                                    if (response.statusCode == 200) {
                                      print("uploaded");

                                      Fluttertoast.showToast(
                                          msg: "Updated Successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 5,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.black,
                                          fontSize: 14.0);

                                      Navigator.pop(context);
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Error'),
                                            content: Text("Error"),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                                text: 'Save',
                                options: FFButtonOptions(
                                  width: 350,
                                  height: 50,
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
                                    width: 10,
                                  ),
                                  borderRadius: 12,
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
    );
  }
}
