import 'dart:convert';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:n_tel_care_family_app/backend/ApiService.dart';
import 'package:n_tel_care_family_app/core/shared_preferences_service.dart';
import 'package:n_tel_care_family_app/critical/critical_widget.dart';
import 'package:n_tel_care_family_app/members/members.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/custom_toast.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:email_validator/email_validator.dart';

// add member
class Add extends StatefulWidget {
  List<dynamic> countries;
  Add({Key key, @required this.countries}) : super(key: key);

  @override
  _AddWidgetState createState() => _AddWidgetState();
}

class _AddWidgetState extends State<Add> {
  final formkey = GlobalKey<FormState>();
  String dropDownValue;
  String dropDownValueGender;
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();
  TextEditingController textController5 = TextEditingController();
  TextEditingController textController6 = TextEditingController();
  TextEditingController textController7 = TextEditingController();
  TextEditingController textController8 = TextEditingController();
  TextEditingController textController9 = TextEditingController();

  dynamic placesData;
  List<dynamic> relationOptions = [];
  String relationCode;
  String relationName;
  bool switchListTileValue;
  bool checkboxListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var color1 = Color(0xFF00B89F);
  var color2 = Color(0xFFD6D6D6);
  var color = Color(0xFFD6D6D6);
  var colorA = Color(0xFFD6D6D6);
  var colorB = Color(0xFFD6D6D6);
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String countryCode;
  DateTime dateTime;
  String Date = "Select";
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    FFAppState().Chattoggle5 = false;
    // print("countries add ${widget.countries}");
    _loadRelation();
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

  /* void vaildMail() {
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
  }*/

  Future pickimage(ImageSource source1) async {
    try {
      final image = await ImagePicker().pickImage(source: source1);
      if (image == null) {
        setState(() {
          display = false;
          return null;
        });
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

  Future<void> _loadRelation() async {
    String uri = '${ApiService.domain}/admin/relations';
    final res = await http.get(
      Uri.parse(uri),
      headers: {
        "Authorization":
            "Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}"
      },
    );
    // print(res.body);
    setState(() {
      relationOptions = jsonDecode(res.body)['data'];
      print(" relation option ${relationOptions}");
    });
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
      cityValue = placesData['data']['county_name'];
      stateValue = placesData['data']['state_name'];
    }
  }

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
                          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 10),
                          child: Text(
                            'Add User',
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
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.44,
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
                                        child: DropdownButtonFormField<String>(
                                          value: dropDownValueGender,
                                          items: [
                                            "Male",
                                            "Female",
                                            "Transgender",
                                          ]
                                              .map((label) => DropdownMenuItem(
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
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.44,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      final DateTime picked =
                                          await showDatePicker(
                                              builder: (_, Widget child) {
                                                return Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                            colorScheme: ColorScheme.light(
                                                                primary: Color(
                                                                    0xFF00B89F),
                                                                secondary:
                                                                    Colors.red),
                                                            textButtonTheme:
                                                                TextButtonThemeData(
                                                                    style: TextButton
                                                                        .styleFrom(
                                                              primary: Color(
                                                                  0xFF00B89F),
                                                            ))),
                                                    child: child);
                                              },
                                              context: context,
                                              initialDate: selectedDate,
                                              firstDate: DateTime(1900, 8),
                                              lastDate: DateTime.now());
                                      if (picked != null &&
                                          picked != selectedDate)
                                        setState(() {
                                          selectedDate = picked;
                                        });
                                      Date = DateFormat('MM-dd-yyyy')
                                          .format(selectedDate);
                                    },
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
                                                    child: Text(Date,
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
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(10, 0, 0, 0),
                                              child: Icon(
                                                Icons.arrow_drop_down_outlined,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Container(
                              key: formkey,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: TextFormField(
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
                                  // onEditingComplete: () => vaildMail(),
                                  // onChanged: (v) => vaildMail(),
                                  keyboardType: TextInputType.emailAddress,
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
                                  controller: textController4,
                                  obscureText: false,
                                  inputFormatters: [
                                    MaskedInputFormatter('###.###.####')
                                  ],
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
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(4, 10, 4, 0),
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
                                                " value of country : ${value}");
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
                                EdgeInsetsDirectional.fromSTEB(4, 10, 4, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: TextFormField(
                                  controller: textController7,
                                  onChanged: (val) => _loadAddress(),
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
                                EdgeInsetsDirectional.fromSTEB(4, 10, 4, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
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
                                EdgeInsetsDirectional.fromSTEB(4, 10, 4, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
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
                                EdgeInsetsDirectional.fromSTEB(4, 10, 4, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
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
                              child: DropdownButtonFormField(
                                value: dropDownValue,
                                items: relationOptions
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label['name']),
                                          value: label['id'],
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() => relationCode = value);
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 8, 0, 0),
                                  child: SwitchListTile(
                                    value: FFAppState().Chattoggle5,
                                    onChanged: (bool value) {
                                      setState(() {
                                        FFAppState().Chattoggle5 = value;
                                        if (FFAppState().Chattoggle5 == false) {
                                          displayChat = false;
                                          displayLive = false;
                                          displayView = false;
                                        } else {
                                          displayChat = true;
                                          displayLive = true;
                                          displayView = true;
                                        }
                                      });
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
                              activeColor: Color(0xFF23ECB9),
                              checkColor: Color(0xFF1F252B),
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
                                              if (FFAppState().Chattoggle5 ==
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
                                          if (FFAppState().Chattoggle5) {
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
                                          if (FFAppState().Chattoggle5) {
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

                              /* Padding(
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
                                                if (color == color1 &&
                                                    displayLive == displayY) {
                                                  color = color2;
                                                  displayLive = displayN;
                                                } else {
                                                  color = color1;
                                                  displayLive = displayY;
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
                                              if (colorA == color1 &&
                                                  displayView == displayY) {
                                                colorA = color2;
                                                displayView = displayN;
                                              } else {
                                                colorA = color1;
                                                displayView = displayY;
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
                                            if (colorB == color1 &&
                                                displayChat == displayY) {
                                              colorB = color2;
                                              displayChat = displayN;
                                            } else {
                                              colorB = color1;
                                              displayChat = displayY;
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
                              )*/
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 30),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (SharedPreferenceService.loadBool(
                                    key: AccountsKeys.Executive)) {
                                  if (textController1.text == "" ||
                                      textController2.text == "" ||
                                      textController5.text == "" ||
                                      textController6.text == "" ||
                                      textController7.text == "" ||
                                      textController4.text == "" ||
                                      dropDownValue == "" ||
                                      dropDownValueGender == "" ||
                                      image == null) {
                                    Toast.showToast(
                                      context,
                                      type: ToastType.Error,
                                      message:
                                          "All fields are necessary to fill",
                                    );
                                  } else {
                                    // print(FFAppState().AccountId);
                                    // print(displayLive.toString());
                                    // print(displayChat.toString());
                                    // print(displayView.toString());
                                    // List<int> imageBytes = image.readAsBytesSync();
                                    // String base64Image = base64Encode(imageBytes);
                                    //BASE64.encode(imageBytes);

                                    final String url =
                                        "${ApiService.domain}/add/member";
                                    /* final res =
                                    await http.post(Uri.parse(url), headers: {
                                  "Authorization": "Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}"
                                 }, body: {
                                  "fname": textController1.text,
                                  "lname": textController2.text,
                                  "email": "hong@gmail.com",
                                  "mobile": textController3.text,
                                  "relation": dropDownValue,
                                  "executive": display.toString(),
                                  "m_acc_id": FFAppState().AccountId,
                                  "age": "80",
                                  "gender": "Female",
                                  "address": "123456",
                                  "zipcode": "123456",
                                  "profile": image,
                                  "live_video": true.toString(),
                                  "chats": displayChat.toString(),
                                  "view_video": displayView.toString(),
                                 });*/
                                    //  print(image.path);
                                    //  var stream =
                                    //     new http.ByteStream(image.openRead());
                                    // stream.cast();

                                    // var length = await image.length();
                                    // print("country add $countryValue");
                                    // print("relation $dropDownValue");

                                    var res1 = new http.MultipartRequest(
                                        'POST', Uri.parse(url));

                                    res1.headers['Authorization'] =
                                        "Bearer ${SharedPreferenceService.loadString(key: AccountsKeys.AccessTokenKey)}";
                                    res1.fields['fname'] = textController1.text;
                                    res1.fields['lname'] = textController2.text;
                                    res1.fields['email'] = textController5.text;
                                    res1.fields['mobile'] = textController4.text
                                        .replaceAll(".", "");
                                    res1.fields['relation'] = relationCode;
                                    res1.fields['executive'] =
                                        FFAppState().Chattoggle5.toString();
                                    res1.fields['m_acc_id'] =
                                        FFAppState().AccountId;

                                    res1.fields['gender'] = dropDownValueGender;
                                    res1.fields['address'] =
                                        textController6.text;
                                    res1.fields['zipcode'] =
                                        textController7.text;
                                    res1.files.add(
                                        await http.MultipartFile.fromPath(
                                            "profile", image.path));
                                    res1.fields['live_video'] =
                                        displayLive.toString();
                                    res1.fields['chat'] =
                                        displayChat.toString();
                                    res1.fields['view_video'] =
                                        displayView.toString();
                                    res1.fields["country"] = countryValue;
                                    res1.fields["state"] = textController8.text;
                                    res1.fields["city"] = textController9.text;
                                    res1.fields["dob"] =
                                        DateFormat("yyyy-MM-dd")
                                            .format(selectedDate);
                                    // ignore: unnecessary_statements
                                    //List<int> imageBytes = image.readAsBytesSync();
                                    // res1.files.add(http.MultipartFile.fromBytes(
                                    // 'profile', imageBytes));
                                    //res1.files.add.(http.MultipartFile.fromPath('profile', image.path));

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
                                    // final result = jsonDecode(res.body);*/
                                    print(response.statusCode);
                                    if (response.statusCode == 200) {
                                      print("uploaded");
                                      Toast.showToast(
                                        context,
                                        type: ToastType.Info,
                                        message: jsonDecode(respStr)["message"],
                                      );

                                      Navigator.pop(context);
                                    } else {
                                      Toast.showToast(
                                        context,
                                        type: ToastType.Error,
                                        message: jsonDecode(respStr)["message"],
                                      );
                                    }
                                  }
                                } else {
                                  Toast.showToast(
                                    context,
                                    type: ToastType.Info,
                                    message:
                                        "You are not permitted to add the members",
                                  );
                                }
                                // setState(() {});
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
