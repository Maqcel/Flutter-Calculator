import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_expressions/math_expressions.dart';

import 'content.dart';

class StateManagement with ChangeNotifier {
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

  void readClose() {
    firstAdvanced = true;
    notifyListeners();
  }

  void extratapped(List<Object> content, int index) {
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

    notifyListeners();
  }

  void tapped(List<Object> content, int index) {
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
// ! equal
      } else if (content[index] == content[19] &&
          equation.isNotEmpty &&
          !equation.startsWith('-')) {
        expression = equation;  // ! Here for checking the operation
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
      notifyListeners();
  }
}
