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
    Icon(Icons.backspace), 8, 5, 2, 0,
    //3
    Icon(MdiIcons.percent), 9, 6, 3, '.',
    //4
    Icon(MdiIcons.division), Icon(MdiIcons.closeThick), Icon(MdiIcons.minus), Icon(MdiIcons.plusThick), Icon(MdiIcons.equal),
  ];

  String equation = '';
  String result = '0';
  String expression = '';

  void _tapped(List<Object> content, int index) {
    setState(() {
      if (content[index] == content[0] ) { //clear
        equation = '';
        result = '0';
      } else if (content[index] == content[5]) { //backspace
        equation = equation.substring(0, equation.length - 1);
        if (equation.isEmpty) equation = '0';
      } else if (content[index] == content[19]) { // =
        expression = equation;
        equation = '';
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = 'ERROR';
        }

      } else {
        if (content[index] == content[10]) {
          equation += '%';
        } else if (content[index] == content[15]) {
          equation += '÷';
        } else if (content[index] == content[16]) {
          equation += '×';
        } else if (content[index] == content[17]) {
          equation += '-';
        } else if (content[index] == content[18]) {
          equation += '+';
        } else {
          equation += content[index].toString();
        }
      }
      //print(equation);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Calculator')),
        backgroundColor: Colors.black87,
      ),
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
                ],
                //crossAxisAlignment: CrossAxisAlignment.end,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.black54,
              height: _screenSize.height * 0.28,
            ),
            Expanded(
              child: Container(
                color: Colors.black87,
                child: Row(
                  children: <Widget>[
                    buildColumn(_screenSize, content, 0, _tapped),
                    buildColumn(_screenSize, content, 5, _tapped),
                    buildColumn(_screenSize, content, 10, _tapped),
                    buildColumn(_screenSize, content, 15, _tapped),
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
