import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_expressions/math_expressions.dart';

import 'content.dart';

class StateManagement with ChangeNotifier {
  List<Object> content = [
    //0
    Icon(Icons.delete_outline), 7, 4, 1, Icon(MdiIcons.plusMinus),
    //5
    Icon(Icons.keyboard_backspace), 8, 5, 2, 0,
    //10
    Icon(MdiIcons.percent), 9, 6, 3, '.',
    //15
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

  void buildFunction(String func, int index, int from) {
    if (content[index] == content[from]) {
      if (equation.isNotEmpty) {
        if (isDigit(equation, equation.length - 1) == false) {
          equation += func;
        }
      } else
        equation += func;
    }
  }

  void extratapped(List<Object> content, int index) {
    //! (
    if (content[index] == content[6]) {
      if (equation.isNotEmpty) {
        if (equation[equation.length - 1] != ')') equation += '(';
      } else
        equation += '(';
    }
    //! )
    else if (content[index] == content[7]) {
      if (equation.isNotEmpty) {
        if (equation[equation.length - 1] != '(') equation += ')';
      } else
        equation += ')';
    }
    //! x^2
    else if (content[index] == content[0]) {
      if (equation.isNotEmpty) {
        if (isDigit(equation, equation.length - 1) ||
            equation[equation.length - 1] == ')') equation += '^2';
      }
    }
    //! x^y
    else if (content[index] == content[8]) {
      if (equation.isNotEmpty) {
        if (isDigit(equation, equation.length - 1) ||
            equation[equation.length - 1] == ')') equation += '^';
      }
    }
    //! sqrt
    buildFunction('sqrt(', index, 3);
    //! sin
    buildFunction('sin(', index, 4);
    //! cos
    buildFunction('cos(', index, 1);
    //! tan
    buildFunction('tan(', index, 2);
    //! log
    buildFunction('ln(', index, 5);
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
    } else if (content[index] == content[19] && equation.isNotEmpty) {
      expression = equation; // ! Here for checking the operation
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
      if (equation.endsWith('-') && index == 17) return null;
      if ((index >= 15 && index < 19) || index == 10) {
        if (equation.endsWith(')')) {
          switch (index) {
            case 10:
              equation += '%';
              break;
            case 15:
              equation += '÷';
              break;
            case 16:
              equation += '×';
              break;
            case 17:
              equation += '-';
              break;
            case 18:
              equation += '+';
              break;
            default:
              return null;
          }
          notifyListeners();
          return null;
        }
        if (equation.isNotEmpty && !isDigit(equation, equation.length - 1)) {
          if (!equation.endsWith('(') && content[index] != content[17])
            return null;
        }
      }
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
        if (equation.isEmpty)
          equation += '-';
        else if (isDigit(equation, equation.length - 1))
          equation += '-';
        else if (equation.endsWith('+') ||
            equation.endsWith('÷') ||
            equation.endsWith('×')) equation += '-';
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
