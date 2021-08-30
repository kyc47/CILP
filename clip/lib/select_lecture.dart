import 'package:clip/lecture1.dart';
import 'package:clip/lecture2.dart';
import 'package:clip/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SelectLecture extends StatefulWidget {
  const SelectLecture({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  _SelectLectureState createState() => _SelectLectureState();
}

class _SelectLectureState extends State<SelectLecture> {
  // String uid = "738b9da95dad4de98b3e4566645695f3";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.3,
            bottom: MediaQuery.of(context).size.height * 0.3),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                "수강 과목을 클릭해주세요.",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple[100]!,
                    spreadRadius: 10,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ElevatedButton(
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(child: Text("1번 강의"))),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:
                            Lecture1(uid: widget.uid),
                        inheritTheme: true,
                        ctx: context),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple[100]!,
                    spreadRadius: 10,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ElevatedButton(
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(child: Text("2번 강의"))),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //       type: PageTransitionType.rightToLeft,
                  //       // child: LeadyToLecture(uid: user.uid.toString(),),
                  //       child: LeadyToLecture(uid:"3d87125ce7c542daa9cfb8caaedcabd9"),
                  //       inheritTheme: true,
                  //       ctx: context),
                  // );
                  // });.
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:
                        Lecture2(uid: widget.uid),
                        inheritTheme: true,
                        ctx: context),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple[100]!,
                    spreadRadius: 10,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: ElevatedButton(
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(child: Text("3번 강의"))),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //       type: PageTransitionType.rightToLeft,
                  //       // child: LeadyToLecture(uid: user.uid.toString(),),
                  //       child: LeadyToLecture(uid:"3d87125ce7c542daa9cfb8caaedcabd9"),
                  //       inheritTheme: true,
                  //       ctx: context),
                  // );
                  // });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
