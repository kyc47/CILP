import 'package:clip/screen_check.dart';
import 'package:clip/lecture_page2.dart';
import 'package:clip/lecture_page3.dart';
import 'package:clip/lecture_page4.dart';
import 'package:clip/model.dart';
import 'package:clip/network.dart';
import 'package:clip/select_lecture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [
          // MediaQuery.of(context).size.width >= 980
          //     ? Menu()
          //     : SizedBox(), // Responsive
          Body()
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: ElevatedButton(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 50,
            child: Center(child: Text("실험 안내 페이지 바로가기"))),
        onPressed: () async {
          const url =
              'https://abiding-moustache-7c8.notion.site/5d1581a9232b4ca798c49f4fd1d26a5b';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _menuItem({String title = 'Title Menu', isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 75),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.deepPurple : Colors.grey,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            isActive
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contactless Interaction\nLecture Project',
                style: GoogleFonts.abel(
                  fontSize: 36,
                  color: Color(0xff084da7),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 30,
              ),
              Image.asset(
                'images/cnu_logo.png',
                width: 300,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),
          child: Container(
            width: 360,
            child: _formLogin(context),
          ),
        )
      ],
    );
  }

  Widget _formLogin(context) {
    TextEditingController _textEditingController = TextEditingController();
    User user = new User();
    bool temp = false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            hintText: '휴대전화 번호를 입력하여 주세요.',
            filled: true,
            fillColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 15),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]!),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]!),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "실험을 신청한 분의 휴대전화 번호를 입력해주세요.",
          style: GoogleFonts.abel(
            fontSize: 15,
            color: Color(0xff084da7),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "실험 관련 문의 : 01040449370",
          style: GoogleFonts.abel(
            fontSize: 15,
            color: Color(0xff084da7),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 40),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey,
                spreadRadius: 3,
                blurRadius: 6,
              ),
            ],
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("시작하기"))),
            onPressed: () async {
              Map map = {'user_id': _textEditingController.value.text};
              var test = await Sign().signIn(map, "sign");
              if (test == null) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('존재하지 않는 정보입니다.'),
                    content:
                        Text('번호를 확인해주세요.\n로그인 실패 시 01040449370으로 문의바랍니다.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              } else {
                Sign().signIn(map, "sign").then((value) {
                  user = value;
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: const Text('전체 화면을 통해 실험을 진행해주세요.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: SelectLecture(
                                      uid: user.uid.toString(),
                                      type: user.user_type.toString()),
                                  inheritTheme: true,
                                  ctx: context),
                            );
                          },
                          child: const Text('확인'),
                        ),
                      ],
                    ),
                  );
                });
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        // ElevatedButton(
        //   child: Container(
        //       width: double.infinity,
        //       height: 50,
        //       child: Center(child: Text("실험 안내 페이지 바로가기"))),
        //   onPressed: () async {
        //     const url =
        //         'https://abiding-moustache-7c8.notion.site/5d1581a9232b4ca798c49f4fd1d26a5b';
        //     if (await canLaunch(url)) {
        //       await launch(url);
        //     } else {
        //       throw 'Could not launch $url';
        //     }
        //   },
        //   style: ElevatedButton.styleFrom(
        //     primary: Colors.orange,
        //     onPrimary: Colors.white,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(15),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
