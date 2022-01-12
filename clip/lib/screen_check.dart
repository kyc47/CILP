import 'package:clip/network.dart';
import 'package:clip/select_lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class LeadyToLecture extends StatefulWidget {
  LeadyToLecture({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _LeadyToLectureState createState() => _LeadyToLectureState();
}

class _LeadyToLectureState extends State<LeadyToLecture> {
  String text = "";
  int touch = 0;
  final _formKey = GlobalKey<FormState>();

  String number = "";
  bool button1 = false;
  bool button2 = false;
  bool button3 = false;
  bool button4 = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // Center(
            //     child: ElevatedButton(
            //   child: Text(
            //     "버튼에 적힌 번호를 순서대로 누르세요.",
            //     style: TextStyle(
            //         color: Colors.blue,
            //         fontSize: 30,
            //         fontWeight: FontWeight.bold),
            //   ),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //         PageTransition(
            //             type: PageTransitionType.rightToLeft,
            //             child: SelectLecture(uid: widget.uid),
            //             inheritTheme: true,
            //             ctx: context)
            //     );
            //
            //   },
            // )),
            Align(
                alignment: Alignment.topRight,
                child: button1
                    ? SizedBox()
                    : GestureDetector(
                        onPanStart: (detail) {
                          double X = detail.globalPosition.dx;
                          double Y = detail.globalPosition.dy;
                          HCILocation()
                              .getScreen(X, Y, widget.uid, "T-R", "screen")
                              .then((value) {
                            setState(() {
                              button1 = true;
                            });
                          });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.height * 0.05,
                          alignment: Alignment.center,
                          color: Colors.blue,
                          child: Text(
                            "1번",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
            Align(
                alignment: Alignment.topLeft,
                child: button2
                    ? SizedBox()
                    : GestureDetector(
                        onPanStart: (detail) {
                          double X = detail.globalPosition.dx;
                          double Y = detail.globalPosition.dy;
                          HCILocation()
                              .getScreen(X, Y, widget.uid, "T-L", "screen")
                              .then((value) {
                            setState(() {
                              if (button1) {
                                button2 = true;
                              }
                            });
                          });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.height * 0.05,
                          alignment: Alignment.center,
                          color: Colors.blue,
                          child: Text(
                            "2번",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
            Align(
                alignment: Alignment.bottomLeft,
                child: button3
                    ? SizedBox()
                    : GestureDetector(
                        onPanStart: (detail) {
                          double X = detail.globalPosition.dx;
                          double Y = detail.globalPosition.dy;
                          HCILocation()
                              .getScreen(X, Y, widget.uid, "B-L", "screen")
                              .then((value) {
                            setState(() {
                              if (button2) {
                                button3 = true;
                              }
                            });
                          });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.height * 0.05,
                          alignment: Alignment.center,
                          color: Colors.blue,
                          child: Text(
                            "3번",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
            // Align(
            //     alignment: Alignment.bottomRight,
            //     child: button4
            //         ? SizedBox()
            //         : GestureDetector(
            //             onPanStart: (detail) {
            //               double X = detail.globalPosition.dx;
            //               double Y = detail.globalPosition.dy;
            //               HCILocation()
            //                   .getScreen(X, Y, widget.uid, "B-R", "screen")
            //                   .then((value) {
            //                 setState(() {
            //                   if (button3) {
            //                     button4 = true;
            //                   }
            //                 });
            //                 PageTransition(
            //                     type: PageTransitionType.rightToLeft,
            //                     child: SelectLecture(uid: widget.uid,),
            //                     // child: LeadyToLecture(
            //                     //     uid: "3d87125ce7c542daa9cfb8caaedcabd9"),
            //                     inheritTheme: true,
            //                     ctx: context);
            //               });
            //             },
            //             child: Container(
            //               height: MediaQuery.of(context).size.height * 0.05,
            //               width: MediaQuery.of(context).size.height * 0.05,
            //               alignment: Alignment.center,
            //               color: Colors.blue,
            //               child: Text(
            //                 "4번",
            //                 style: TextStyle(color: Colors.white),
            //               ),
            //             ),
            //           )),
          ],
        ),
      ),
    );
  }
}
