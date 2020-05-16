import 'package:calculator/main_drawer.dart';
import 'package:calculator/readme.dart';
import 'package:calculator/states.dart';
import 'package:provider/provider.dart';

import 'content.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => StateManagement())],
      child: MyApp(),
    ),
  );
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

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stateManagement = Provider.of<StateManagement>(context);
    final _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _screenSize.height >= 700
          ? AppBar(
              title: Container(
                margin: EdgeInsets.symmetric(horizontal: _screenSize.width / 5),
                child: Text('Calculator'),
              ),
              backgroundColor: Colors.black87,
            )
          : null,
      drawer: stateManagement.firstAdvanced
          ? MainDrawer(stateManagement.extratapped)
          : ReadMe(),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: ListView(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      stateManagement.equation.isEmpty
                          ? '0'
                          : stateManagement.equation,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  Divider(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      stateManagement.result,
                      style: TextStyle(fontSize: 40, color: Colors.black54),
                    ),
                  ),
                  if (stateManagement.lastEquation.isNotEmpty &&
                      stateManagement.result.toString() != 'ERROR TRY AGAIN!')
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        stateManagement.lastEquation,
                        style: TextStyle(fontSize: 23, color: Colors.black38),
                      ),
                    ),
                ],
                //crossAxisAlignment: CrossAxisAlignment.end,
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.black54,
              height: _screenSize.height * 0.25,
            ),
            Expanded(
              child: Container(
                color: Colors.black87,
                child: Row(
                  children: <Widget>[
                    for (int i = 0; i < 20; i += 5)
                      buildColumn(_screenSize, stateManagement.content, i,
                          stateManagement.tapped, 5),
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
