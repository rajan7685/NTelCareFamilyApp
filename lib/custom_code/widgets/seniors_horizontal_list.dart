import 'package:flutter/material.dart';
import 'package:n_tel_care_family_app/flutter_flow/flutter_flow_theme.dart';

import '../../app_state.dart';

class SeniorsHori extends StatelessWidget {
  SeniorsHori({this.ontap, this.setState, this.SList, this.color, this.inf});
  final Function ontap, setState;
  final Color color;
  dynamic inf;

  final Future<dynamic> SList;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFF1F252B),
      ),
      child: FutureBuilder<dynamic>(
          future: SList,
          builder: (context, snapshot) {
            inf = snapshot.data;
            print(inf);
            // setState(() {
            //   selectedId = inf[0]["id"];
            // });
            if (!snapshot.hasData) {
              return Text(
                "Loading...",
                style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Color(0xFFE5E5E5),
                    fontSize: 20),
              );
            } else {
              Future.delayed(
                Duration(seconds: 3),
                setState,
                // () {
                //   setState(() {
                //     selectedId = inf[0]["id"];
                //   });
                // }
              );

              return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final id = inf[index]["id"];
                    FFAppState().id = id;
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(

                            // Colors.transparent

                            //Color(0xFF1F252B).withOpacity(1),
                            ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              onTap: ontap,
                              //  () {
                              //   setState(() {
                              //     selectedId = id;
                              //   });
                              //   _isSelected(index);
                              // }

                              child: Container(
                                width: 70,
                                height: 70,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: color
                                    // isSelected == true
                                    //     ? Colors.red
                                    //     : Colors.black,
                                    ),
                                child: Image.network(
                                  inf[index]["profile"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          inf[index]["fname"] +
                                              " " +
                                              inf[index]["lname"],
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: color,
                                                // isSelected != null &&
                                                //         isSelected == index
                                                //     ? Color(0xFF00B89F)
                                                //     : Color(0xFF535353),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 2, 0, 0),
                                        child: Text(
                                          "Age " +
                                              inf[index]["age"] +
                                              ", " +
                                              inf[index]["gender"],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: color,
                                                //  isSelected != null &&
                                                //         isSelected == index
                                                //     ? Color(0xFFE5E5E5)
                                                //     : Color(0xFF535353),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: ontap,
                                    // () async {
                                    //   await Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               EditSeniorsWidget(
                                    //                   data: snapshot
                                    //                       .data[index])));
                                    // },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 6, 0, 0),
                                          child: Text(
                                            'More Info',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: color,
                                                  //  isSelected != null &&
                                                  //         isSelected == index
                                                  //     ? Colors.blue
                                                  //     : Color(0xFF535353),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w200,
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
                    );
                  });
            }
          }),
    );
  }
}
