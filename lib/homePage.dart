import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RoundedButton.dart';
import 'function.dart';
import 'package:clipboard/clipboard.dart';
import 'screenSize.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// bool get isScreenWide {
//   if (ScreenSize.orientation == Orientation.landscape)
//     return true;
//   else
//     return false;
// }

class _HomePageState extends State<HomePage> {
  String jsonString;
  String dartClasses = "Dart classes will appear here";
  var textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var lines;
    var boxWidth;
    var textSize;
    var space;
    var headingSize;
    bool isScreenWide;
    if (MediaQuery.of(context).size.width > 700)
      isScreenWide = true;
    else
      isScreenWide = false;
    ScreenSize.recalculate(context);
    if (ScreenSize.w * 100 < 800) {
      lines = (ScreenSize.h * (1.6)).round();
      boxWidth = 250;
      textSize = 10;
      headingSize = 30;
      space = ScreenSize.h * 4;
      if (ScreenSize.h * 100 < 800) lines = 6;
    } else {
      lines = (ScreenSize.h * (1.6)).round();
      boxWidth = 340;
      textSize = 12;
      headingSize = 45;
      space = ScreenSize.h * 20;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    "JSON to Dart Converter",
                    style: TextStyle(
                      fontSize: headingSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(
                  height: space,
                ),
                Flex(
                  direction: isScreenWide ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: boxWidth,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            cursorColor: Colors.black,
                            maxLines: lines,
                            keyboardType: TextInputType.multiline,
                            obscureText: false,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Enter your JSON string here',
                              labelStyle: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                            onChanged: (value) {
                              jsonString = value;
                            },
                          ),
                          RoundedButton(
                            title: "GENERATE",
                            colour: Colors.teal,
                            onPressed: () {
                              Garg garg = Garg(jsonString: jsonString);
                              setState(() {
                                dartClasses = garg.calc();
                                textController.text = dartClasses;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: boxWidth,
                      child: Column(
                        children: [
                          TextField(
                            controller: textController,
                            cursorColor: Colors.black,
                            readOnly: true,
                            maxLines: lines,
                            keyboardType: TextInputType.multiline,
                            obscureText: false,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: "Dart classes will appear here",
                              labelStyle: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          RoundedButton(
                            title: "COPY",
                            colour: Colors.teal,
                            onPressed: () {
                              FlutterClipboard.copy(dartClasses);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: space,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Github Repo ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: textSize,
                        ),
                      ),
                      TextSpan(
                        text: 'here',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: textSize,
                          //fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(
                                'https://github.com/invictus-15/Json-to-Dart-Generator');
                          },
                      )
                    ]),
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Team Members: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: textSize,
                          ),
                        ),
                        TextSpan(
                          text: 'HARSH GARG , ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: textSize,
                            //fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  'https://www.linkedin.com/in/harshgarg15/');
                            },
                        ),
                        TextSpan(
                          text: 'MOHIT KUMAR SINGH , ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: textSize,
                            //fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  'https://www.linkedin.com/in/harshgarg15/');
                            },
                        ),
                        TextSpan(
                          text: 'PARAM SHARMA',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: textSize,
                            //fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                  'https://www.linkedin.com/in/paramasalways/');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
