import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if (buttonText == 'c')
        {
          equation='0';
          result = '0';
          equationFontSize=38;
          resultFontSize=48;
        }
      else if (buttonText == '⌫' ){
        equationFontSize=48;
        resultFontSize=38;
        equation = equation.substring(0,equation.length-1);
        if (equation ==''){
          equation='0';
        }
      }
      else if (buttonText == '=')
      {
        equationFontSize=38;
        resultFontSize=48;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }
        catch(e){
          result='ERROR';
        }
      }
      else {
        equationFontSize=38;
        resultFontSize=48;
           if(equation == '0')
           {
             equation = buttonText;
           }
           else
           {
             equation = equation + buttonText;
           }

      }
    });

  }
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Table(
        children: [
          TableRow(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: buttonColor,
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide(
                    color: Colors.white,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                onPressed: () => buttonPressed(buttonText),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Simple Calculator',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(
                fontSize: equationFontSize,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                fontSize: resultFontSize,
              ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("c", 1, Colors.red.shade900),
                      buildButton("⌫", 1, Colors.blue.shade900),
                      buildButton("÷", 1, Colors.blue.shade900),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.blueGrey),
                      buildButton("8", 1, Colors.blueGrey),
                      buildButton("9", 1, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      buildButton("6", 1, Colors.blueGrey),
                      buildButton("5", 1, Colors.blueGrey),
                      buildButton("4", 1, Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      buildButton("3", 1, Colors.blueGrey),
                      buildButton("2", 1, Colors.blueGrey),
                      buildButton("1", 1,Colors.blueGrey),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.blueGrey),
                      buildButton("0", 1, Colors.blueGrey),
                      buildButton("00", 1, Colors.blueGrey),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("*", 1, Colors.blue.shade900),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1,Colors.blue.shade900),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1,Colors.blue.shade900),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 2, Colors.blue.shade900),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
