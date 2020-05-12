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
    Size size, List<Object> content, int index, Function tapped) {
  return Column(
    children: <Widget>[
      buildContainer(size, content, index, tapped),
      buildContainer(size, content, index + 1, tapped),
      buildContainer(size, content, index + 2, tapped),
      buildContainer(size, content, index + 3, tapped),
      buildContainer(size, content, index + 4, tapped),
    ],
    crossAxisAlignment: CrossAxisAlignment.center,
  );
}
bool isDigit(String s, int idx) => (s.codeUnitAt(idx) ^ 0x30) <= 9;
String changeSign(String exp){
  String modified = exp;
  bool cond = true;
   
  return  modified;
}