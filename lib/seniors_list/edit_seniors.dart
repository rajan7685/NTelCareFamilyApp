import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:n_tel_care_family_app/backend/ApiService.dart';
import 'package:n_tel_care_family_app/core/shared_preferences_service.dart';
import 'package:n_tel_care_family_app/critical/critical_widget.dart';
import 'package:n_tel_care_family_app/landing/landing.dart';
import 'package:n_tel_care_family_app/seniors_list/senior_list.dart';
import 'package:image_picker/image_picker.dart';
import '../backend/api_requests/api_calls.dart';
import 'package:path/path.dart';
import 'package:csc_picker/csc_picker.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:email_validator/email_validator.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class EditSeniorsWidget extends StatefulWidget {
  dynamic data;
  List<dynamic> countries;
  EditSeniorsWidget({Key key, @required this.data, @required this.countries})
      : super(key: key);

  @override
  _EditSeniorsWidgetState createState() => _EditSeniorsWidgetState(data);
}

class _EditSeniorsWidgetState extends State<EditSeniorsWidget> {
  final formkey = GlobalKey<FormState>();
  String dropDownValue1;
  //TextEditingController textController3;
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  TextEditingController textController4; // height
  TextEditingController textController5; // weight
  TextEditingController textController6;
  TextEditingController textController7;
  TextEditingController textController8;
  TextEditingController textController9;
  TextEditingController textController10;
  TextEditingController textController11;
  TextEditingController inchesController;
  String dropDownValue2;
  String dropDownValue3;
  String dropDownValue4;
  String dropDownValue5;
  String dropDownValueGender;
  bool display = false;
  bool displayY = true;
  bool displayN = false;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  String heightUnit;
  String weightUnit;
  String countryCode;
  String dateJson;
  DateTime dateTime;
  DateTime selectedDate;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic data;
  dynamic placesData;
  var profile = null;

  // permission for editing
  bool _hasPermissionToEdit;

  _EditSeniorsWidgetState(this.data);

  @override
  void initState() {
    super.initState();
    String phoneNumber = data["mobile"];
    print("senior: ${data["weight_unit"]} ${data["height_unit"]}");
    textController6 = TextEditingController(text: "");
    // units
    weightUnit = data["weight_unit"] == "lbs" ? "lbs" : "kg";
    heightUnit = data["height_unit"] == "ft" ? "feet" : "cm";
    textController1 = TextEditingController(text: data["fname"]);
    textController2 = TextEditingController(text: data["lname"]);
    dropDownValueGender = data["gender"];
    textController4 = TextEditingController(text: data['height']);
    textController5 = TextEditingController(text: data['weight']);
    textController6 = TextEditingController(text: data["mobile"]);
    textController7 = TextEditingController(text: data["email"]);
    textController8 = TextEditingController(text: data['address']);
    textController9 = TextEditingController(text: data["zipcode"]);
    textController10 = TextEditingController(text: data["state"]);
    textController11 = TextEditingController(text: data["city"]);
    inchesController = TextEditingController(text: data["inchs"]);

    profile = data["profile"];
    if (profile == null) {
      profile =
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYL2_7f_QDJhq5m9FYGrz5W4QI5EUuDLSdGA&usqp=CAU";
    }
    FFAppState().SeniorId = data["id"];

    cityValue = data["city"];
    countryValue = data["country"];
    countryCode = data['ccode'];
    stateValue = data["state"];
    selectedDate = HttpDate.parse(data["dob"]);
    _hasPermissionToEdit =
        SharedPreferenceService.loadBool(key: AccountsKeys.Executive);
  }

  void vaildMail() {
    final bool isVaild = EmailValidator.validate(textController7.text.trim());
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

  File image;
  Future<File> savePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name1 = basename(imagePath);
    final image2 = File('${directory.path}/$name1');
    return File(imagePath).copy(image2.path);
  }

  Future pickimage(ImageSource source1) async {
    try {
      final image =
          await ImagePicker().pickImage(source: source1, imageQuality: 20);
      if (image == null) {
        return null;
      }
      final imagePath = File(image.path);
      // final imagePathPermanently = await savePermanently(image.path);
      setState(() => this.image = imagePath);
      setState(() {
        display = false;
      });
    } on PlatformException catch (e) {
      print("Permission Denied");
    }
  }

  Future<void> _loadAddress() async {
    String uri =
        '${ApiService.domain}/zipcode/${countryCode.toLowerCase()}/${textController9.text}';
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
      print("outside plcae data: $placesData");
      print(placesData);
      setState(() {
        textController10.text = placesData['data']['state_name'];
        textController11.text = placesData['data']['county_name'];
      });
      dynamic countryValue = widget.countries.singleWhere((element) =>
          element['code'] == placesData['data']['country_code'])['name'];
      cityValue = placesData['data']['county_name'];
      stateValue = placesData['data']['state_name'];
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("executive : ${FFAppState().executive}");
    // print("edit senior countries : ${widget.countries}");
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
                                size: 40,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CriticalWidget(),
                                  ));
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
                          padding: EdgeInsetsDirectional.fromSTEB(15, 15, 0, 0),
                          child: Text(
                            data["fname"] + " " + data["lname"],
                            textAlign: TextAlign.start,
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
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 45, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                child: TextFormField(
                                  enabled: _hasPermissionToEdit,
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
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF606E87),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
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
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF606E87),
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: TextFormField(
                                  enabled: _hasPermissionToEdit,
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
                                        fontFamily: 'Montserrat',
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
                                        child: IgnorePointer(
                                          ignoring: !_hasPermissionToEdit,
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 0, 3),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
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
                                                          color:
                                                              Color(0xFF9A9A9A),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                                  child: Text(
                                                      DateFormat("MM-dd-yyyy")
                                                          .format(selectedDate),
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            if (_hasPermissionToEdit) {
                                              final DateTime picked =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate: selectedDate,
                                                      firstDate:
                                                          DateTime(1900, 8),
                                                      lastDate: DateTime.now());
                                              if (picked != null &&
                                                  picked != selectedDate)
                                                setState(() {
                                                  selectedDate = picked;
                                                });
                                            }
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
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: TextFormField(
                                            enabled: _hasPermissionToEdit,
                                            controller: textController4,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Height',
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF9A9A9A),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w300,
                                                  ),
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
                                                  color: Color(0xFF606E87),
                                                  fontSize: 16,
                                                ),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: IgnorePointer(
                                            ignoring: !_hasPermissionToEdit,
                                            child:
                                                DropdownButtonFormField<String>(
                                              value: heightUnit,
                                              items: ["feet", "cm"]
                                                  .map((label) =>
                                                      DropdownMenuItem(
                                                        child: Text(label),
                                                        value: label,
                                                      ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(
                                                    () => heightUnit = value);
                                              },
                                              decoration: InputDecoration(
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 0),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                // filled: true,
                                                // fillColor: Color(0xFFEEEEEE),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFF606E87),
                                                      ),
                                              hint: Text('unit'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              if (heightUnit == "feet")
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEEEEEE),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: TextFormField(
                                        enabled: _hasPermissionToEdit,
                                        controller: inchesController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Inches',
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
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
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
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
                                )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 0, 0, 0),
                                          child: TextFormField(
                                            enabled: _hasPermissionToEdit,
                                            controller: textController5,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Weight',
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyText1
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xFF9A9A9A),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w300,
                                                  ),
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
                                                  color: Color(0xFF606E87),
                                                  fontSize: 16,
                                                ),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: IgnorePointer(
                                            ignoring: !_hasPermissionToEdit,
                                            child:
                                                DropdownButtonFormField<String>(
                                              value: weightUnit,
                                              items: ["lbs", "kg"]
                                                  .map((label) =>
                                                      DropdownMenuItem(
                                                        child: Text(label),
                                                        value: label,
                                                      ))
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(
                                                    () => weightUnit = value);
                                              },
                                              decoration: InputDecoration(
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 0),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                // filled: true,
                                                // fillColor: Color(0xFFEEEEEE),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            Color(0xFF606E87),
                                                      ),
                                              hint: Text('unit'),
                                            ),
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
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: TextFormField(
                                  enabled: _hasPermissionToEdit,
                                  controller: textController6,
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
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: TextFormField(
                                  enabled: _hasPermissionToEdit,
                                  controller: textController7,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Email\n',
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
                                  keyboardType: TextInputType.emailAddress,
                                  /*  validator: (value) => value != null &&
                                          !EmailValidator.validate(value)
                                      ? 'Enter a valid email'
                                      : null,*/
                                  onEditingComplete: () => vaildMail(),
                                  onChanged: (v) => vaildMail(),
                                  //validator: (value) => vaildMail(),
                                  onFieldSubmitted: (value) => vaildMail(),
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
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: IgnorePointer(
                                      ignoring: !_hasPermissionToEdit,
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
                                          String abc = widget.countries
                                              .firstWhere((element) =>
                                                  element['code'] ==
                                                  value)['name'];
                                          // print("value of country" + abc);
                                          setState(() {
                                            // print(" value of country : ${value}");
                                            countryCode = value;
                                            countryValue = abc;
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: TextFormField(
                                  enabled: _hasPermissionToEdit,
                                  controller: textController9,
                                  obscureText: false,
                                  onChanged: (value) => _loadAddress(),
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
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: TextFormField(
                                  enabled: false,
                                  controller: textController10,
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
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: TextFormField(
                                  enabled: _hasPermissionToEdit,
                                  controller: textController11,
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
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: TextFormField(
                                  enabled: _hasPermissionToEdit,
                                  controller: textController8,
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
                            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 0, 0),
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
                                          alignment:
                                              AlignmentDirectional(1.34, 0.97),
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
                                                      if (_hasPermissionToEdit) {
                                                        setState(() {
                                                          if (display ==
                                                              displayN) {
                                                            display = displayY;
                                                          } else {
                                                            display = displayN;
                                                          }
                                                        });
                                                      }
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 2, 0, 0),
                                                    child: Text(
                                                      'Gallery',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Montserrat',
                                                            color: Color(
                                                                0xFF1F252B),
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
                          if (_hasPermissionToEdit)
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 30),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final form = formkey.currentState;
                                  if (textController1.text == "" ||
                                      textController2.text == "" ||
                                      dropDownValueGender == "" ||
                                      textController4.text == "" ||
                                      textController5.text == "" ||
                                      textController6.text == "" ||
                                      textController7.text == "" ||
                                      textController8.text == "" ||
                                      textController9.text == "" ||
                                      countryValue == "" ||
                                      stateValue == "||" ||
                                      cityValue == "") {
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

                                    final String url =
                                        "${ApiService.domain}/edit/senior/${FFAppState().SeniorId}";
                                    var res = new http.MultipartRequest(
                                        'POST', Uri.parse(url));

                                    res.headers['Authorization'] =
                                        "Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}";
                                    res.fields["senior_id"] =
                                        FFAppState().SeniorId;

                                    res.fields["fname"] = textController1.text;
                                    res.fields["lname"] = textController2.text;
                                    res.fields["mobile"] = textController6.text
                                        .replaceAll(".", "");
                                    res.fields["email"] = textController7.text;
                                    res.fields["gender"] = dropDownValueGender;
                                    res.fields["height"] = textController4.text;
                                    res.fields["weight"] = textController5.text;
                                    if (inchesController.text.isNotEmpty) {
                                      res.fields["inchs"] =
                                          inchesController.text;
                                    }
                                    res.fields["weight_unit"] = weightUnit;
                                    res.fields["height_unit"] =
                                        heightUnit == "feet" ? "ft" : "cm";
                                    res.fields["address"] =
                                        textController8.text;
                                    res.fields["zipcode"] =
                                        textController9.text;
                                    res.fields["blood_group"] = "o+";
                                    res.fields["age"] = "89";
                                    res.fields["dob"] = DateFormat("yyyy-MM-dd")
                                        .format(selectedDate);
                                    res.fields["country"] = countryValue;
                                    res.fields["state"] = textController10.text;
                                    res.fields["city"] = textController11.text;

                                    /*profile == null
                                    ? res.files.add(
                                        await http.MultipartFile.fromPath(
                                            "profile", image.path))
                                    : res.files.add(http.MultipartFile.fromString(
                                        "profile", profile));*/

                                    final http.Response responseData =
                                        await http.get(Uri.parse(profile));
                                    print(res.fields);
                                    Uint8List uint8list =
                                        responseData.bodyBytes;
                                    var buffer = uint8list.buffer;
                                    ByteData byteData = ByteData.view(buffer);
                                    var tempDir = await getTemporaryDirectory();
                                    File file =
                                        await File('${tempDir.path}/img')
                                            .writeAsBytes(buffer.asUint8List(
                                                byteData.offsetInBytes,
                                                byteData.lengthInBytes));
                                    print(file.path);
                                    /*image == null
                                        ? res.files.add(
                                            await http.MultipartFile.fromPath(
                                                "profile", file.path))
                                        : res.files.add(
                                            await http.MultipartFile.fromPath(
                                                "profile", image.path));*/
                                    if (image != null) {
                                      res.files.add(
                                          await http.MultipartFile.fromPath(
                                              "profile", image.path));
                                    }
                                    var response = await res.send();

                                    print(response.statusCode);
                                    final resp =
                                        await response.stream.bytesToString();
                                    if (response.statusCode == 200) {
                                      print("uploaded");
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg: "Updated Successfully!",
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
                                            content: Text(
                                                jsonDecode(resp)["message"]),
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
                                text: 'Update',
                                options: FFButtonOptions(
                                  width: 350,
                                  height: 40,
                                  color: Color(0xFF00B89F),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 12,
                                ),
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
    );
  }

  Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();

    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }
}
