import 'package:clip/screen_check.dart';
import 'package:clip/lecture_page2.dart';
import 'package:clip/lecture_page3.dart';
import 'package:clip/lecture_page4.dart';
import 'package:clip/model.dart';
import 'package:clip/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [
          Menu(),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _menuItem(title: 'Home'),
              _menuItem(title: 'About us'),
              _menuItem(title: 'Contact us'),
              _menuItem(title: 'Help'),
            ],
          ),
        ],
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
                // style: TextStyle(
                //   fontFamily: GoogleF,
                //   fontSize: 36,
                //   color: Colors.deepPurple,
                //   fontWeight: FontWeight.bold,
                // ),
                style: GoogleFonts.abel(
                  fontSize: 36,
                  color: Colors.deepPurple,
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
            width: 320,
            child: _formLogin(context),
          ),
        )
      ],
    );
  }

  Widget _formLogin(context) {
    TextEditingController _textEditingController = TextEditingController();
    User user = new User();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: '전달받은 번호를 입력해주세요.',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
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
        ),
        SizedBox(height: 40),
        Container(
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
                child: Center(child: Text("시작하기"))),
            onPressed: () {
              Map map = {'user_id': _textEditingController.value.text};
              print(map);
              Sign().signIn(map, "sign").then((value) {
                user = value;
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: LeadyToLecture(uid: user.uid.toString(),),
                      // child: LeadyToLecture(uid:"3d87125ce7c542daa9cfb8caaedcabd9"),
                      inheritTheme: true,
                      ctx: context),
                );
              });
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
        SizedBox(height: 40),
        // Container(
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(30),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.deepPurple[100]!,
        //         spreadRadius: 10,
        //         blurRadius: 20,
        //       ),
        //     ],
        //   ),
        //   child: ElevatedButton(
        //     child: Container(
        //         width: double.infinity,
        //         height: 50,
        //         child: Center(child: Text("Sign Up"))),
        //     onPressed: () => print("it's pressed"),
        //     style: ElevatedButton.styleFrom(
        //       primary: Colors.deepPurple,
        //       onPrimary: Colors.white,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(15),
        //       ),
        //     ),
        //   ),
        // ),
        // Row(
        //   children: [
        //     Container(
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(30),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.deepPurple[100]!,
        //             spreadRadius: 10,
        //             blurRadius: 20,
        //           ),
        //         ],
        //       ),
        //       child: ElevatedButton(
        //         child: Container(
        //             width: 20, height: 20, child: Center(child: Text("T2"))),
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             PageTransition(
        //                 type: PageTransitionType.rightToLeft,
        //                 child: LectureType2(),
        //                 inheritTheme: true,
        //                 ctx: context),
        //           );
        //         },
        //         style: ElevatedButton.styleFrom(
        //           primary: Colors.deepPurple,
        //           onPrimary: Colors.white,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(15),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Container(
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(30),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.deepPurple[100]!,
        //             spreadRadius: 10,
        //             blurRadius: 20,
        //           ),
        //         ],
        //       ),
        //       child: ElevatedButton(
        //         child: Container(
        //             width: 20, height: 20, child: Center(child: Text("T3"))),
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             PageTransition(
        //                 type: PageTransitionType.rightToLeft,
        //                 child: LectureType3(),
        //                 inheritTheme: true,
        //                 ctx: context),
        //           );
        //         },
        //         style: ElevatedButton.styleFrom(
        //           primary: Colors.deepPurple,
        //           onPrimary: Colors.white,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(15),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Container(
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(30),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.deepPurple[100]!,
        //             spreadRadius: 10,
        //             blurRadius: 20,
        //           ),
        //         ],
        //       ),
        //       child: ElevatedButton(
        //         child: Container(
        //             width: 20, height: 20, child: Center(child: Text("백엔드테스트"))),
        //         onPressed: () async{
        //           Map data = {"email": "email10", "password": "passwod","phone_number":"010404444444"};
        //           String name = "user";
        //           await signup(data, name);
        //         },
        //         style: ElevatedButton.styleFrom(
        //           primary: Colors.deepPurple,
        //           onPrimary: Colors.white,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(15),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Container(
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(30),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.deepPurple[100]!,
        //             spreadRadius: 10,
        //             blurRadius: 20,
        //           ),
        //         ],
        //       ),
        //       child: ElevatedButton(
        //         child: Container(
        //             width: 20, height: 20, child: Center(child: Text("T4"))),
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             PageTransition(
        //                 type: PageTransitionType.rightToLeft,
        //                 child: LectureType4(),
        //                 inheritTheme: true,
        //                 ctx: context),
        //           );
        //         },
        //         style: ElevatedButton.styleFrom(
        //           primary: Colors.deepPurple,
        //           onPrimary: Colors.white,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(15),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
