import 'package:flutter/material.dart';

Widget buildContainer(Size size, List<Object> content, int index,Function tapped) {
    return Container(
      child: InkWell(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: InkWell(
              child: Center(
                child: content[index] is Icon
                    ? content[index]
                    : Text(
                        content[index].toString(),
                        style: TextStyle(fontSize: 30),
                      ),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.only(top: 5),
            width: size.width * 0.24,
            height: size.width * 0.24,
          ),
        ),
        borderRadius: BorderRadius.circular(15),
        onTap:() => tapped(content,index),
      ),
      width: size.width * 0.25,
      height: size.width * 0.25,
    );
  }

  Widget buildColumn(Size size, List<Object> content, int index,Function tapped) {
    return Column(
      children: <Widget>[
        buildContainer(size, content, index,tapped),
        buildContainer(size, content, index + 1,tapped),
        buildContainer(size, content, index + 2,tapped),
        buildContainer(size, content, index + 3,tapped),
        buildContainer(size, content, index + 4,tapped),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }