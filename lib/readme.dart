import 'package:calculator/states.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class FadeEndListview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.black87.withOpacity(0.6), Colors.white38],
      )),
      height: 15,
    );
  }
}

Column buildListTile(FontWeight fontWeight, double fontSize, Color color,
    String text, Icon icon, bool spacing) {
  return Column(
    children: <Widget>[
      ListTile(
        leading: icon,
        title: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize, fontWeight: fontWeight, color: color),
          ),
        ),
      ),
      spacing
          ? SizedBox(
              height: 30,
            )
          : SizedBox(
              height: 5,
            ),
    ],
  );
}

class ReadMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stateManagement = Provider.of<StateManagement>(context);
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: _screenSize.width / 4.5),
          child: Text('ReadMe'),
        ),
        backgroundColor: Colors.black87,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        child: Icon(Icons.check),
        onPressed: () => {
          Navigator.of(context).pop(true),
          stateManagement.readClose(),
        },
      ),
      body: Column(
        children: <Widget>[
          buildListTile(
              FontWeight.bold, 40, Colors.red, 'Working formats:', null, false),
          Expanded(
            child: Stack(
              children: [
                FadeEndListview(),
                ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    buildListTile(
                      FontWeight.normal,
                      _screenSize.width * 0.05 + _screenSize.height * 0.0005,
                      Colors.black87,
                      'Sinus function after clicking the button on screen the body will apear: \'sin(\' after this you can pass the value of sinus you want to count, and remember to close function with: \')\'',
                      Icon(MdiIcons.mathSin),
                      true,
                    ),
                    buildListTile(
                      FontWeight.normal,
                      _screenSize.width * 0.05 + _screenSize.height * 0.0005,
                      Colors.black87,
                      'Cosinus function after clicking the button on screen the body will apear: \'cos(\' after this you can pass the value of cosinus you want to count, and remember to close function with: \')\'',
                      Icon(MdiIcons.mathCos),
                      true,
                    ),
                    buildListTile(
                      FontWeight.normal,
                      _screenSize.width * 0.05 + _screenSize.height * 0.0005,
                      Colors.black87,
                      'Tanges function after clicking the button on screen the body will apear: \'tan(\' after this you can pass the value of tanges you want to count, and remember to close function with: \')\'',
                      Icon(MdiIcons.mathTan),
                      true,
                    ),
                    buildListTile(
                      FontWeight.normal,
                      _screenSize.width * 0.05 + _screenSize.height * 0.0005,
                      Colors.black87,
                      '', // TODO: Check how log works
                      Icon(MdiIcons.mathLog),
                      true,
                    ),
                    buildListTile(
                      FontWeight.normal,
                      _screenSize.width * 0.05 + _screenSize.height * 0.0005,
                      Colors.black87,
                      'Square function after clicking the button on screen the body will apear: \'x^2\' where x is the last written value, or can we combined with operation in parenthesis \'(x+y)^2\'',
                      Icon(MdiIcons.formatSuperscript),
                      true,
                    ),
                    buildListTile(
                      FontWeight.normal,
                      _screenSize.width * 0.05 + _screenSize.height * 0.0005,
                      Colors.black87,
                      'Square function after clicking the button on screen the body will apear: \'x^y\' where x is the last written value and y is the value of the power. Can be combined with operation in parenthesis \'(x+y)^z\' Where z can be also and operation in parenthesis',
                      Icon(MdiIcons.exponent),
                      true,
                    ),
                    buildListTile(
                      FontWeight.normal,
                      _screenSize.width * 0.05 + _screenSize.height * 0.0005,
                      Colors.black87,
                      'Square Root function after clicking the button on screen the body will apear: \'sqrt(\' after this you can pass the value you want to calculate square root of, and remember to close function with: \')\'',
                      Icon(MdiIcons.squareRoot),
                      true,
                    ),
                    buildListTile(
                      FontWeight.normal,
                      _screenSize.width * 0.05 + _screenSize.height * 0.0005,
                      Colors.black87,
                      'Parenthesis buttons adding \'(\' and \')\' to the equation. Example: \'(x+b)*(a+d)\'',
                      Icon(MdiIcons.variable),
                      false,
                    ),
                    buildListTile(
                      FontWeight.bold,
                      _screenSize.width * 0.05 + _screenSize.height * 0.0005,
                      Colors.red,
                      'Continue',
                      null,
                      true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
