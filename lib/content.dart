import 'package:flutter/material.dart';

Widget buildContainer(
    Size size, List<Object> content, int index, Function tapped) {
  return Container(
    margin: EdgeInsets.all(size.height * 0.0024),
    width: size.width * 0.24,
    height: size.width * 0.24,
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      border: Border.all(width: 1, color: Colors.black87),
    ),
    child: FlatButton(
      child: Center(
        child: content[index] is Icon
            ? content[index]
            : Text(
                content[index].toString(),
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
      ),
      onPressed: () => tapped(content, index),
    ),
  );
}

Widget buildColumn(
    Size size, List<Object> content, int index, Function tapped, int howMuch) {
  //add flex!
  return Column(
    children: <Widget>[
      for (int i = 0; i < howMuch; i++)
        Expanded(
          child: buildContainer(size, content, index + i, tapped),
        ),
    ],
    crossAxisAlignment: CrossAxisAlignment.center,
  );
}

bool isDigit(String s, int idx) => (s.codeUnitAt(idx) ^ 0x30) <= 9;
String changeSign(String exp) {
  String modified = exp;
  int i = modified.length - 1;
  if (modified.length == 1) {
    return modified = '-' + modified;
  }
  while (isDigit(modified, i)) {
    i--;
    if (i == -1) break;
  }
  if (i > 0) {
    if (modified[i] == '+') {
      modified = modified.substring(0, i) +
          '-' +
          modified.substring(i + 1, exp.length);
    } else if (modified[i] == '-') {
      modified =
          modified.substring(0, i) + modified.substring(i + 1, exp.length);
    }
  } else if (i == -1) {
    return '-' + modified;
  } else
    return modified.substring(1, modified.length);
  return modified;
}
