import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RoundedButton.dart';
import 'function.dart';
import 'package:clipboard/clipboard.dart';
import 'screenSize.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dartClasses = "Dart classes will appear here";
  TextEditingController dartOutputController = TextEditingController();
  Widget visibleWidget = Container();
  bool isFirstTime = true;
  TextEditingController jsonInputController = TextEditingController();

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
      if (ScreenSize.h * 100 < 800) lines = 10;
    } else {
      lines = (ScreenSize.h * (1.6)).round();
      boxWidth = 340;
      textSize = 12;
      headingSize = 45;
      space = ScreenSize.h * 20;
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          Tooltip(
            message: 'Go to Github Repo',
            child: InkWell(
              onHover: (value) => null,
              onTap: () {
                launch('https://github.com/invictus-15/Json-to-Dart-Generator');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  FontAwesomeIcons.github,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),
        ],
        title: Center(
          child: Text(
            'JSON to Dart Converter',
            style: TextStyle(
              fontSize: headingSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: space / 7,
              ),
              Flex(
                direction: isScreenWide ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: boxWidth * 1.3,
                    child: AnimatedSwitcher(
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: (isFirstTime)
                          ? jsonInputWidget(lines)
                          : visibleWidget,
                      duration: Duration(milliseconds: 500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: space / 5,
              ),
              Container(
                width: boxWidth * 1.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TEAM MEMBERS:',
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        launch('https://www.linkedin.com/in/harshgarg15/');
                      },
                      child: Text(
                        'HARSH GARG, ',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        launch('https://www.linkedin.com/in/mrunfunny/');
                      },
                      child: Text(
                        'MOHIT SINGH, ',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        launch('https://www.linkedin.com/in/paramasalways/');
                      },
                      child: Text(
                        'PARAM SHARMA',
                        style: TextStyle(decoration: TextDecoration.underline),
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

  Column dartOutputWidget(lines) {
    return Column(
      key: ValueKey<int>(0),
      children: [
        TextField(
          controller: dartOutputController,
          cursorColor: Colors.black,
          readOnly: true,
          maxLines: lines * 2,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: RoundedButton(
                title: "COPY",
                colour: Colors.teal,
                onPressed: () {
                  FlutterClipboard.copy(dartClasses);
                },
              ),
            ),
            Flexible(
              child: RoundedButton(
                title: "TRY AGAIN",
                colour: Colors.teal,
                onPressed: () {
                  setState(() {
                    visibleWidget = jsonInputWidget(lines);
                    jsonInputController.clear();
                  });
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Column jsonInputWidget(lines) {
    TextEditingController classNameText = TextEditingController();
    return Column(
      key: ValueKey<int>(1),
      children: <Widget>[
        TextField(
          controller: jsonInputController,
          cursorColor: Colors.black,
          maxLines: lines * 2,
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
        ),
        SizedBox(height: 24),
        TextField(
          controller: classNameText,
          maxLines: 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'Enter Class Name here',
            labelStyle: TextStyle(
              color: Colors.black45,
            ),
          ),
        ),
        RoundedButton(
          title: "GENERATE",
          colour: Colors.teal,
          onPressed: () {
            Garg garg = Garg(
                jsonString: jsonInputController.text,
                className: (classNameText.text.trim() != null &&
                        classNameText.text.trim() != '')
                    ? classNameText.text.trim().contains(' ')
                        ? classNameText.text.trim().replaceAll(' ', '_')
                        : classNameText.text.trim()
                    : 'Generated');

            setState(() {
              dartClasses = garg.calc();
              if (dartClasses == null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text('The format of input json is incorrect.'),
                    actions: [
                      FlatButton(
                        child: Text('Okay'),
                        onPressed: () {
                          jsonInputController.clear();
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                );
              } else {
                isFirstTime = false;
                dartOutputController.text = dartClasses;

                visibleWidget = dartOutputWidget(lines);
              }
            });
          },
        ),
      ],
    );
  }
}
