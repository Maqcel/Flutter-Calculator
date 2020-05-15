import 'package:flutter/material.dart';

Container buildContainer(FontWeight fontWeight, double fontSize, Color color,
    String text, Icon icon) {
  if (icon != null) {
    text = '\t' + text;
  }
  return Container(
    // width: ,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (icon != null) icon,
        Expanded(
          child: Text(text,
              style: TextStyle(
                  fontWeight: fontWeight, fontSize: fontSize, color: color)),
        ),
      ],
    ),
  );
}

class ReadMe extends StatelessWidget {
  static const String routeName = 'readme';
  @override
  Widget build(BuildContext context) {
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
        child: Icon(Icons.check),
        onPressed: () => {Navigator.of(context).pop(true)},
      ),
      body: Container(),
    );
  }
}
/*Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildContainer(
                FontWeight.bold, 40, Colors.red, 'Working formats:', null),
            buildContainer(
                FontWeight.normal,
                30,
                Colors.black87,
                'Sinus function after clicking the button on screen the body will apear: \'sin(\' after this you can pass the value of sinus u want to count, and remember to close function with: \')\'',
                null),
          ],
        ),
*/
