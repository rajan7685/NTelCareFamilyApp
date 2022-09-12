import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:n_tel_care_family_app/backend/ApiService.dart';
import 'package:n_tel_care_family_app/backend/api_requests/api_calls.dart';
import 'package:n_tel_care_family_app/backend/api_requests/api_manager.dart';
import 'package:n_tel_care_family_app/critical/critical_widget.dart';
import 'package:n_tel_care_family_app/landing/landing.dart';
import 'package:http/http.dart' as http;
// import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';

import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  final bool self;
  final dynamic messageContent;
  const ChatBox({Key key, @required this.messageContent, @required this.self})
      : super(key: key);

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  bool showSeen = false;
  List<String> seenPersons = [];

  @override
  void initState() {
    super.initState();
    if (widget.messageContent["read_by"] != null) {
      (widget.messageContent["read_by"] as List<dynamic>)
          .forEach((dynamic data) {
        seenPersons.add((data["name"] as String).split(" ")[0]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: !widget.self ? 8 : 0,
          right: widget.self ? 8 : 0,
          top: 6,
          bottom: 6),
      child: Column(
        crossAxisAlignment:
            widget.self ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45,
                height: 45,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  widget.messageContent['profile'] ??
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYL2_7f_QDJhq5m9FYGrz5W4QI5EUuDLSdGA&usqp=CAU",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showSeen = !showSeen;
                  });
                },
                child: Flexible(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8),
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * .2,
                        maxWidth: MediaQuery.of(context).size.width * .7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.messageContent["message"],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF209A1F),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: widget.messageContent['document'] == null
                            ? Radius.circular(10)
                            : Radius.circular(0),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                left: !widget.self ? 8 : 0, right: widget.self ? 8 : 0),
            child: Row(
              mainAxisAlignment:
                  widget.self ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Icon(
                  FontAwesomeIcons.checkDouble,
                  color: widget.messageContent['all_read']
                      ? Colors.blue
                      : Colors.white,
                  size: 10,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  DateFormat('hh:mm a').format(
                      DateTime.parse(widget.messageContent['date_time'])
                          .toLocal()),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFFE5E5E5),
                        fontSize: 8,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: !widget.self ? 8 : 0,
              right: widget.self ? 8 : 0,
            ),
            child: Row(
              mainAxisAlignment:
                  widget.self ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Flexible(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * .2,
                        maxWidth: MediaQuery.of(context).size.width * .7),
                    height: showSeen ? 30 : 0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Text(
                        seenPersons.isEmpty
                            ? 'Nobody has seen yet'
                            : 'Seen by ${seenPersons.join(", ")}',
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChatWidget extends StatefulWidget {
  const ChatWidget({Key key}) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _chatController;
  List<dynamic> _chats;
  bool _isChatDataLoading = true;
  XFile _image;
  String _accHolderName = '';

  // FilePickerResult;

  Future<void> _loadMessages({bool init = false}) async {
    if (!init)
      setState(() {
        _isChatDataLoading = true;
      });
    String uri = '${ApiService.domain}/get_chats/member';
    final res = await http.get(Uri.parse(uri),
        headers: {"Authorization": "Bearer ${FFAppState().Token}"});
    Map<String, dynamic> _responseJson = jsonDecode(res.body);
    final ApiCallResponse profileInfo = await GetProfile.call();
    _accHolderName =
        '${profileInfo.jsonBody['member']['fname']} ${profileInfo.jsonBody['member']['lname']}';
    setState(() {
      _chats = _responseJson['chats'];
      _isChatDataLoading = false;
    });
  }

  // Future<void> _pickFile() async {
  //   final ImagePicker _picker = ImagePicker();
  //   // Pick an image
  //   final XFile image = await _picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     _image = image;
  //   }
  // }

  // Future<void> _downloadFile({String fileUrl}) async {
  //   //
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text('File is being downloaded')));
  //   Directory _dir = await getApplicationDocumentsDirectory();
  //   String _timeStamp = DateTime.now().millisecond.toString();
  //   String _fileName = fileUrl.split('/').last;
  //   await Dio().download(fileUrl, '${_dir.path}/$_timeStamp $_fileName');
  //   await OpenFile.open('${_dir.path}/$_timeStamp $_fileName');
  //   // print('${_dir.path}/$_timeStamp $_fileName');
  // }

  Future<void> _sendMessage() async {
    if (_chatController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter something to send')));
      return;
    }
    String uri = '${ApiService.domain}/send_chat/member';
    var formData = FormData.fromMap({
      'message': _chatController.text,
      // 'document': null
      'document': _image == null
          ? null
          : await MultipartFile.fromFile(_image.path, filename: _image.name)
    });
    try {
      Response response = await Dio().post(uri,
          data: formData,
          options: Options(
              headers: {"Authorization": "Bearer ${FFAppState().Token}"}));
      _chatController.text = '';
      _image = null;
      _loadMessages();
    } catch (e) {
      print('error ${e.toString()}');
    }
    // "Bearer ${FFAppState().Token}"
    // final res = await http.post(Uri.parse(uri),
    //     body: {"message": _chatController.text, "document": null},
    //     headers: {"Authorization": "Bearer ${FFAppState().Token}"});
    // Map<String, dynamic> _responseJson = jsonDecode(res.body);
    // print(res.body);
  }

  @override
  void initState() {
    super.initState();
    _chatController = TextEditingController();
    _loadMessages(init: true);
  }

  Widget chatWidget(int index, {@required bool me}) {
    print(_chats[index]['profile']);
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(!me ? 10 : 0, 20, me ? 10 : 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
            child: Container(
              width: 45,
              height: 45,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                _chats[index]['profile'] == null ||
                        (_chats[index]['profile'] as String).isEmpty
                    ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYL2_7f_QDJhq5m9FYGrz5W4QI5EUuDLSdGA&usqp=CAU"
                    : _chats[index]['profile'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: InkWell(
                      onTap: () {
                        // if (_chats[index]['document'] != null)
                        //   _downloadFile(fileUrl: _chats[index]['document']);
                      },
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width * 0.2,
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF209A1F),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: _chats[index]['document'] == null
                                ? Radius.circular(10)
                                : Radius.circular(0),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 7, 12, 7),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // if (_chats[index]['document'] != null)
                              //   Icon(
                              //     Icons.file_download,
                              //     size: 13,
                              //     color: Colors.white,
                              //   ),
                              // if (_chats[index]['document'] != null)
                              //   SizedBox(
                              //     width: 6,
                              //   ),
                              Flexible(
                                child: Text(
                                  _chats[index]['message'],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
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
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('hh:mm a').format(
                        DateTime.parse(_chats[index]['date_time']).toLocal()),
                    // _chats[index]['date_time'],
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Color(0xFFE5E5E5),
                          fontSize: 6,
                        ),
                  ),
                  //Spacer(),
                  SizedBox(width: 8),
                  if (me)
                    Icon(
                      FontAwesomeIcons.checkDouble,
                      color: _chats[index]['all_read']
                          ? Colors.blue
                          : Colors.white,
                      size: 9,
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF1F252B),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(7, 31, 10, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ModifiedLandingPageWidget()));
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
                                  Align(
                                    alignment:
                                        AlignmentDirectional(0.05, -0.43),
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
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Family Chat',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFE5E5E5),
                                      fontSize: 40,
                                      fontWeight: FontWeight.w200,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFF273628),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: _isChatDataLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : RefreshIndicator(
                                onRefresh: () => _loadMessages(),
                                child: ListView.builder(
                                  // reverse: true,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _chats.length,
                                  itemBuilder: (_, int index) => chatWidget(
                                      index,
                                      me: _chats[index]['by'] ==
                                          _accHolderName),
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .95,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              controller: _chatController,
                              obscureText: false,
                              decoration: InputDecoration(
                                isCollapsed: true,
                                // prefix: InkWell(
                                //   // onTap: _pickFile,
                                //   child: Transform.rotate(
                                //     angle: 45,
                                //     child: Icon(
                                //       Icons.attach_file,
                                //       size: 25,
                                //       color: Color(0xFF209A1F),
                                //     ),
                                //   ),
                                // ),
                                suffix: InkWell(
                                  onTap: _sendMessage,
                                  child: Image.asset(
                                    'assets/images/7830587_send_email_icon.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                isDense: true,
                                // labelText: 'Last Name',
                                hintText: 'Type here to send...',
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                filled: true,

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
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*import 'package:n_tel_care_family_app/critical/critical_widget.dart';
import 'package:n_tel_care_family_app/landing/landing.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({Key key}) : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF1F252B),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(7, 31, 10, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ModifiedLandingPageWidget()));
                                //Navigator.pop(context);
                                //   await Navigator.push(
                                //  context,
                                //  MaterialPageRoute(
                                //   builder: (context) =>
                                //      ModifiedLandingPageWidget(),
                                //  ),
                                // );
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
                                  Align(
                                    alignment:
                                        AlignmentDirectional(0.05, -0.43),
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
                                              style: FlutterFlowTheme.of(
                                                      context)
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Family Chat',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFE5E5E5),
                                      fontSize: 40,
                                      fontWeight: FontWeight.w200,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFF273628),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 5, 0),
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/726/600',
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 10, 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEEEEEE),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 7, 12, 7),
                                                child: Text(
                                                  'Hi All',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            '03:59 pm',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFFE5E5E5),
                                                  fontSize: 6,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFF00B89F),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 7, 12, 7),
                                              child: Text(
                                                'hi steve',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '04:00 pm',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFFE5E5E5),
                                                  fontSize: 6,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/678/600',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 5, 0),
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/726/600',
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 10, 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFFCC00),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 7, 12, 7),
                                                child: Text(
                                                  'Hi All',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            '03:59 pm',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFFE5E5E5),
                                                  fontSize: 6,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 20, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFF0063B8),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 7, 12, 7),
                                              child: Text(
                                                'hi steve',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            '04:00 pm',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFFE5E5E5),
                                                  fontSize: 6,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/678/600',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 5, 0),
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://picsum.photos/seed/726/600',
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 10, 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFF209A1F),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(12, 7, 12, 7),
                                                child: Text(
                                                  'Hi All',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            '03:59 pm',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0xFFE5E5E5),
                                                  fontSize: 6,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
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
                // Column(
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container(
                //       width: double.infinity,
                //       decoration: BoxDecoration(
                //         color: Color(0xFF1A1A1A),
                //       ),
                //       child: Padding(
                //         padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                //         child: Card(
                //           clipBehavior: Clip.antiAliasWithSaveLayer,
                //           color: Color(0xFFF5F5F5),
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           child: Padding(
                //             padding:
                //                 EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                //             child: Row(
                //               mainAxisSize: MainAxisSize.max,
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 TextField(
                //                   decoration: InputDecoration(
                //                       border: InputBorder.none,
                //                       hintText: "Type Here",
                //                       hintStyle:
                //                           TextStyle(color: Color(0xFFE5E5E5))),
                //                 ),
                //                 Image.asset(
                //                   'assets/images/7830587_send_email_icon.png',
                //                   width: 25,
                //                   height: 25,
                //                   fit: BoxFit.fill,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
