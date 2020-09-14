import 'dart:io';

import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';
import 'package:process_run/shell.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TermDroid',
      theme: ThemeData(),
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  var ipaddr;
  Dashboard({this.ipaddr});
  @override
  _DashboardState createState() => _DashboardState(ipaddr);
}

class _DashboardState extends State<Dashboard> {
  var shell = Shell();
  var ipaddr;
  _DashboardState(this.ipaddr);
  var op = " ";
  var error = "";
  var msgLine = " ";
  String commandName = " ";
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Termdroid'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Text(
              'Execute commands on Android',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter the command",
                  border: OutlineInputBorder(),
                ),
                onChanged: (x) {
                  commandName = x;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Execute'),
              onPressed: () async {
                await Process.run(commandName, ['1']).then((ProcessResult pr) {
                  print(pr.exitCode);
                  op = pr.stdout;
                  error = pr.stderr;
                  print(pr.stdout);
                  print(pr.stderr);
                });
                setState(() {
                  op = op;
                  error = error;
                });
              },
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    '$error',
                  ),
                  Text(
                    '${op ?? "output will show up here"}',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
