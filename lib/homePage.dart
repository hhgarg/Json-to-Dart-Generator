import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RoundedButton.dart';
import 'function.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String jsonString;
  String dartClasses = "Dart classes will appear here";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: Text(
                "JSON to Dart Converter",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 350,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        cursorColor: Colors.black,
                        maxLines: 12,
                        keyboardType: TextInputType.multiline,
                        obscureText: false,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
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
                          print(jsonString);
                        },
                      ),
                      RoundedButton(
                        title: "GENERATE",
                        colour: Colors.teal,
                        onPressed: () {
                          Garg garg = Garg(jsonString: jsonString);

                          setState(() {
                            dartClasses = garg.calc();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 350,
                  child: Column(
                    children: [
                      TextField(
                        cursorColor: Colors.black,
                        readOnly: true,
                        maxLines: 12,
                        keyboardType: TextInputType.multiline,
                        obscureText: false,
                        style: TextStyle(
                          color: Colors.black12,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelText: dartClasses,
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 63,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Team Members: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: 'HARSH GARG , ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://www.linkedin.com/in/harshgarg15/');
                        },
                    ),
                    TextSpan(
                      text: 'MOHIT KUMAR SINGH , ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://www.linkedin.com/in/harshgarg15/');
                        },
                    ),
                    TextSpan(
                      text: 'PARAM SHARMA',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://www.linkedin.com/in/paramasalways/');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
