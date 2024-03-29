import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:csc_picker/csc_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:n_tel_care_family_app/backend/ApiService.dart';
import 'package:n_tel_care_family_app/core/shared_preferences_service.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:string_extensions/string_extensions.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class EditMemberWidget extends StatefulWidget {
  dynamic data;
  List<dynamic> countries;
  String title;
  EditMemberWidget(
      {Key key,
      @required this.countries,
      @required this.data,
      @required this.title})
      : super(key: key);

  @override
  _EditMemberWidgetState createState() => _EditMemberWidgetState(data, title);
}

class _EditMemberWidgetState extends State<EditMemberWidget> {
  final formKey = GlobalKey<FormState>();
  String dropDownValue;
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  TextEditingController textController4;
  TextEditingController textController5;
  TextEditingController textController6;
  TextEditingController textController7;
  TextEditingController textController8, textController9;

  bool display = false;
  bool displayY = true;
  bool displayN = false;
  bool displayLive = false;
  bool displayChat = false;
  bool displayView = false;
  String countryValue;
  String countryCode;
  String stateValue = "";
  String cityValue = "";
  String address = "";
  String dropDownValueGender;
  String dateJson;
  DateTime dateTime;
  DateTime selectedDate;
  bool switchListTileValue;
  bool checkboxListTileValue;
  ApiCallResponse apiCallOutput;
  dynamic data;
  dynamic placesData;
  String title;
  var profile = null;
  String idOfMem;

  // permission for editing
  bool _hasPermissionToEdit;

  _EditMemberWidgetState(this.data, this.title);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    textController1 = TextEditingController(text: data["fname"]);
    textController2 = TextEditingController(text: data["lname"]);
    textController4 = TextEditingController(text: data['mobile']);
    textController5 = TextEditingController(text: data['email']);
    textController6 = TextEditingController(text: data["address"]);
    textController7 = TextEditingController(text: data["zipcode"]);
    textController8 = TextEditingController(text: data["state"]);
    textController9 = TextEditingController(text: data["city"]);
    idOfMem = data['id'];
    countryCode = data['ccode'];
    // print(" edit member ${widget.countries}");
    if (countryCode != null) {
      countryValue = widget.countries.firstWhere((dynamic countryModel) =>
          countryModel['code'] == countryCode)['name'];
    }
    profile = data["profile"];
    if (profile == null) {
      profile =
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYL2_7f_QDJhq5m9FYGrz5W4QI5EUuDLSdGA&usqp=CAU";
    }
    dropDownValueGender = data["gender"];
    cityValue = data["city"];
    stateValue = data["state"];
    dropDownValue = FFAppState().relation.contains(data["relation"])
        ? data["relation"]
        : null;
    selectedDate = DateTime.parse(data["dob"]);
    print(data["dob"]);
    FFAppState().Chattoggle3 = data['executive'];

    if (data['executive'] == true) {
      displayLive = displayChat = displayView = true;
    } else {
      displayLive = data["permission"]["live_video"];
      displayChat = data["permission"]["chat"];
      displayView = data["permission"]["view_video"];
    }
    if (idOfMem == FFAppState().CurrentUserId) {
      displayLive = data["permission"]["live_video"];
      displayChat = data["permission"]["chat"];
      displayView = data["permission"]["view_video"];
    }
    _hasPermissionToEdit =
        SharedPreferenceService.loadBool(key: AccountsKeys.Executive);
    // _hasPermissionToEdit = true;
  }

  var color1 = Color(0xFF00B89F);
  var color2 = Color(0xFFD6D6D6);
  var color = Color(0xFFD6D6D6);
  var colorA = Color(0xFFD6D6D6);
  var colorB = Color(0xFFD6D6D6);

  File image;
  Future<File> savePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name1 = basename(imagePath);
    final image2 = File('${directory.path}/$name1');
    return File(imagePath).copy(image2.path);
  }

  void vaildMail() {
    final bool isVaild = EmailValidator.validate(textController5.text.trim());
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
      if (image == null) {
        return null;
      }
      final imagePath = File(image.path);

      //final imagePathPermanently = await savePermanently(image.path);
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
  Widget build(BuildContext context) {
    // print(data);
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
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 10),
                          child: Text(
                            title,
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
                                                      DateFormat('MM-dd-yyyy')
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
                                  controller: textController4,
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
                                  inputFormatters: [
                                    MaskedInputFormatter('###.###.####')
                                  ],
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: TextFormField(
                                    enabled: _hasPermissionToEdit,
                                    controller: textController5,
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
                                    /* validator: (value) => value != null &&
                                          !EmailValidator.validate(value)
                                      ? 'Enter a valid email'
                                      : null,*/
                                    onEditingComplete: () => vaildMail(),
                                    onChanged: (v) => vaildMail()),
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
                                          print("value of country" + abc);
                                          setState(() {
                                            print(
                                                " value of country : ${value}");
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: TextFormField(
                                  enabled: false,
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
                              child: IgnorePointer(
                                ignoring: !_hasPermissionToEdit,
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
                                      borderSide: BorderSide(
                                          color: Color(0xFFEEEEEE), width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 2),
                                      borderRadius: BorderRadius.circular(10),
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 0),
                                  child: SwitchListTile(
                                    value: FFAppState().Chattoggle3,
                                    onChanged: (bool value) => setState(() {
                                      if (idOfMem !=
                                          FFAppState().CurrentUserId) {
                                        FFAppState().Chattoggle3 = value;
                                        if (FFAppState().Chattoggle3 == false) {
                                          displayChat = false;
                                          displayLive = false;
                                          displayView = false;
                                        } else {
                                          displayChat = true;
                                          displayLive = true;
                                          displayView = true;
                                        }
                                      }
                                    }),
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
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: displayLive ? color1 : color,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 1, 10, 1),
                                          child: InkWell(
                                            onTap: () async {
                                              if (idOfMem !=
                                                  FFAppState().CurrentUserId) {
                                                if (FFAppState().Chattoggle3 ==
                                                    true) {
                                                  setState(() {
                                                    // displayLive = !displayLive;
                                                    // displayChat = true;
                                                    displayLive = true;
                                                    // displayView = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    displayLive = !displayLive;
                                                  });
                                                }
                                              }
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
                                                          color: displayLive
                                                              ? color1
                                                              : color,
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
                                          color: displayView ? color1 : color,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          if (idOfMem !=
                                              FFAppState().CurrentUserId) {
                                            if (FFAppState().Chattoggle3) {
                                              setState(() {
                                                // displayLive = !displayLive;
                                                // displayChat = true;
                                                displayView = true;
                                                // displayView = true;
                                              });
                                            } else {
                                              setState(() {
                                                displayView = !displayView;
                                              });
                                            }
                                          }
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
                                                color: color1,
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
                                                        color: displayView
                                                            ? color1
                                                            : color,
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF292929),
                                        borderRadius: BorderRadius.circular(5),
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color: displayChat ? color1 : color,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(
                                          0.1499999999999999, 0),
                                      child: InkWell(
                                        onTap: () async {
                                          if (idOfMem !=
                                              FFAppState().CurrentUserId) {
                                            if (FFAppState().Chattoggle3) {
                                              setState(() {
                                                // displayLive = !displayLive;
                                                // displayChat = true;
                                                displayChat = true;
                                                // displayView = true;
                                              });
                                            } else {
                                              setState(() {
                                                displayChat = !displayChat;
                                              });
                                            }
                                          }
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
                                                            : color,
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
                          if (_hasPermissionToEdit)
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 10),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  if (textController1.text == "" ||
                                      textController2.text == "" ||
                                      textController4.text == "" ||
                                      textController6.text == "" ||
                                      textController7.text == "" ||
                                      dropDownValue == "" ||
                                      countryValue == "" ||
                                      stateValue == "" ||
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
                                    final String url =
                                        "${ApiService.domain}/edit/member/${data["id"]}";

                                    FFAppState().executive =
                                        FFAppState().Chattoggle3;
                                    var res1 = new http.MultipartRequest(
                                        'POST', Uri.parse(url));
                                    // print(textController5.text);
                                    res1.headers['Authorization'] =
                                        "Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}";
                                    res1.fields['fname'] = textController1.text;
                                    res1.fields['lname'] = textController2.text;
                                    res1.fields['gender'] = dropDownValueGender;
                                    res1.fields['mobile'] = textController4.text
                                        .replaceAll(".", "");
                                    res1.fields['email'] = textController5.text;
                                    res1.fields['address'] =
                                        textController6.text;
                                    res1.fields['zipcode'] =
                                        textController7.text;
                                    res1.fields['relation'] = dropDownValue;
                                    res1.fields['executive'] =
                                        FFAppState().Chattoggle3.toString();
                                    res1.fields["dob"] =
                                        DateFormat("yyyy-MM-dd")
                                            .format(selectedDate);
                                    res1.fields["country"] = countryValue;
                                    res1.fields["state"] = stateValue;
                                    res1.fields["city"] = cityValue;
                                    res1.fields['live_video'] =
                                        displayLive.toString().capitalize;
                                    res1.fields['chat'] =
                                        displayChat.toString().capitalize;
                                    res1.fields['view_video'] =
                                        displayView.toString().capitalize;
                                    print(res1.fields);
                                    final http.Response responseData =
                                        await http.get(Uri.parse(profile));
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

                                    image == null
                                        ? res1.files.add(
                                            await http.MultipartFile.fromPath(
                                                "profile", file.path))
                                        : res1.files.add(
                                            await http.MultipartFile.fromPath(
                                                "profile", image.path));

                                    var response = await res1.send();
                                    // ignore: unnecessary_statements
                                    //List<int> imageBytes = image.readAsBytesSync();
                                    // res1.files.add(http.MultipartFile.fromBytes(
                                    // 'profile', imageBytes));
                                    //res1.files.add.(http.MultipartFile.fromPath('profile', image.path));

                                    // final result = jsonDecode(res.body);
                                    // print(data?.jsonBody[0].runtimeType);

                                    //if ((getJsonField(
                                    //  (data?.jsonBody ?? ''),
                                    //  r'''$[:].Error''',
                                    //)) ==
                                    // ('Nill'))
                                    // print(
                                    //     'requesting to ${ApiService.domain}/edit/member/${data["id"]}');
                                    // print('requesting with ${res1.fields}');
                                    // print("this is the status code");
                                    print(response.statusCode);
                                    final respStr =
                                        await response.stream.bytesToString();
                                    // final result = jsonDecode(res.body);*/
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print("uploaded");

                                      Fluttertoast.showToast(
                                          msg: jsonDecode(respStr)["message"],
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
                                            content: Text(
                                                jsonDecode(respStr)["message"]),
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
                                  // setState(() {});
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
                          //Delete User

                          if (_hasPermissionToEdit &&
                              idOfMem != FFAppState().CurrentUserId)
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text('Are you sure?'),
                                        content: Text('Delete the user'),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              apiCallOutput =
                                                  await DeleteUserCall.call(
                                                      memberId: data["id"]);
                                              print("this is the status code");
                                              print(apiCallOutput.statusCode);
                                              print(FFAppState().MemberId);
                                              if (apiCallOutput.statusCode ==
                                                  200) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Member Deleted Successfully",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 5,
                                                    backgroundColor:
                                                        Colors.green,
                                                    textColor: Colors.black,
                                                    fontSize: 14.0);

                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Text('Yes'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text('Cancel'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                text: 'Delete User',
                                options: FFButtonOptions(
                                  width: 350,
                                  height: 40,
                                  color: FlutterFlowTheme.of(context).alternate,
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
