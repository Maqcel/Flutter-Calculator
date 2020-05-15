import 'package:calculator/readme.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'content.dart';

class MainDrawerCondition extends StatelessWidget {
  final bool firstAdvanced;
  final Function _readClose;
  final Function _extraTapped;

  const MainDrawerCondition(
      this.firstAdvanced, this._readClose, this._extraTapped);

  @override
  Widget build(BuildContext context) {
    return firstAdvanced ? MainDrawer(_extraTapped) : ReadMe();
  }
}

class MainDrawer extends StatelessWidget {
  final Function _function;

  final List<Object> content = [
    //0
    Icon(MdiIcons.formatSuperscript), Icon(MdiIcons.mathCos),
    Icon(MdiIcons.mathTan),
    //3
    Icon(MdiIcons.squareRoot), Icon(MdiIcons.mathSin), Icon(MdiIcons.mathLog),
    //6
    '(', ')', Icon(MdiIcons.exponent),
  ];

  MainDrawer(this._function);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      width: _screenSize.width * 0.75,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Colors.black87,
              child: Text(
                'More operands',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.white70),
              ),
            ),
            Container(
              height: _screenSize.height - 120,
              color: Colors.black54,
              child: Row(
                children: <Widget>[
                  for (int i = 0; i < 9; i += 3)
                    buildColumn(_screenSize, content, i, _function, 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
