import 'package:calculator/main_drawer.dart';
import 'package:calculator/readme.dart';

import 'content.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomeScreen(),
        ReadMe.routeName: (context) => ReadMe(),
      },
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<Object> content = [
    //1
    Icon(Icons.delete_outline), 7, 4, 1, Icon(MdiIcons.plusMinus),
    //2
    Icon(Icons.keyboard_backspace), 8, 5, 2, 0,
    //3
    Icon(MdiIcons.percent), 9, 6, 3, '.',
    //4
    Icon(MdiIcons.division), Icon(MdiIcons.closeThick), Icon(MdiIcons.minus),
    Icon(MdiIcons.plusThick), Icon(MdiIcons.equal),
  ];

  String equation = '';
  String result = '0';
  String expression = '';
  String lastEquation = '';
  bool insideLog = false;
  bool insideFunc = false;
  bool firstAdvanced = false;

  void _tapped(List<Object> content, int index) {
    setState(() {
      if (content[index] == content[0]) {
        //clear
        equation = '';
        result = '0';
      } else if (content[index] == content[4] && equation.isNotEmpty) {
        equation = changeSign(equation);
      } else if (content[index] == content[5]) {
        //backspace
        equation = equation.substring(0, equation.length - 1);
        if (equation.isEmpty) equation = '0';
/*equal*/
      } else if (content[index] == content[19] &&
          equation.isNotEmpty &&
          !equation.startsWith('-')) {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        //expression = expression.replaceAll('π', '3.14159265359');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'ERROR TRY AGAIN!';
        }
        lastEquation = equation;
        equation = '';
        insideLog = false;
        insideFunc = false;
      } else {
        if (content[index] == content[10] && equation.isNotEmpty) {
          equation.length == 1
              ? isDigit(equation, 0) ? equation += '%' : equation += ''
              : equation += '%';
        } else if (content[index] == content[15] && equation.isNotEmpty) {
          equation.length == 1
              ? isDigit(equation, 0) ? equation += '÷' : equation += ''
              : equation += '÷';
        } else if (content[index] == content[16] && equation.isNotEmpty) {
          equation.length == 1
              ? isDigit(equation, 0) ? equation += '×' : equation += ''
              : equation += '×';
        } else if (content[index] == content[17] && !equation.startsWith('-')) {
          equation.length == 1
              ? isDigit(equation, 0) ? equation += '-' : equation += ''
              : equation += '-';
        } else if (content[index] == content[18] && equation.isNotEmpty) {
          equation.length == 1
              ? isDigit(equation, 0) ? equation += '+' : equation += ''
              : equation += '+';
        } else {
          equation += content[index].toString().length > 1
              ? ''
              : content[index].toString();
        }
      }
      //print(equation);
    });
  }

  void _readClose() {
    print('No ten');
    firstAdvanced = true;
  }

  void _extratapped(List<Object> content, int index) {
    setState(() {
      if (content[index] == content[6]) {
        if (equation.length == 0)
          equation += '(';
        else if (equation[equation.length - 1] != ')') equation += '(';
      }
      if (content[index] == content[7]) {
        if (equation.length == 0)
          equation += '(';
        else if (equation[equation.length - 1] != '(') equation += ')';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _screenSize.height >= 700
          ? AppBar(
              title: Container(
                margin: EdgeInsets.symmetric(horizontal: _screenSize.width / 5),
                child: Text('Calculator'),
              ),
              backgroundColor: Colors.black87,
            )
          : null,
      drawer: MainDrawerCondition(firstAdvanced, _readClose, _extratapped),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: ListView(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      equation.isEmpty ? '0' : equation,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  Divider(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: TextStyle(fontSize: 40, color: Colors.black54),
                    ),
                  ),
                  if (lastEquation.isNotEmpty && result != 'ERROR TRY AGAIN!')
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        lastEquation,
                        style: TextStyle(fontSize: 23, color: Colors.black38),
                      ),
                    ),
                ],
                //crossAxisAlignment: CrossAxisAlignment.end,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.black54,
              height: _screenSize.height * 0.25,
            ),
            Expanded(
              child: Container(
                color: Colors.black87,
                child: Row(
                  children: <Widget>[
                    for (int i = 0; i < 20; i += 5)
                      buildColumn(_screenSize, content, i, _tapped, 5),
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
