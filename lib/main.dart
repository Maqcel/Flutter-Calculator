import 'content.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    Icon(MdiIcons.division), Icon(MdiIcons.closeThick), Icon(MdiIcons.minus),
    Icon(MdiIcons.plusThick), Icon(MdiIcons.equal)
  ];

  bool hover = false;

  void _tapped(List<Object> content,int index){
    print(content[index]);
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
              color: Colors.black54,
              height: _screenSize.height * 0.28,
            ),
            Expanded(
              child: Container(
                color: Colors.black87,
                child: Row(
                  children: <Widget>[
                    buildColumn(_screenSize, content, 0,_tapped),
                    buildColumn(_screenSize, content, 5,_tapped),
                    buildColumn(_screenSize, content, 10,_tapped),
                    buildColumn(_screenSize, content, 15,_tapped),
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
