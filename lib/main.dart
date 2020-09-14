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
      title: 'Flutter Demo',
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
  var msgLine = " ";
  String commandName = " ";
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('RemoteManagementApp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 5,
            ),
            Text(
              'Execute commands on server',
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
                await Process.run('cal', ['1']).then((ProcessResult pr) {
                  print(pr.exitCode);
                  op = pr.stdout;
                  print(pr.stdout);
                  print(pr.stderr);
                });
                setState(() {
                  commandName = op;
                });
                print(op);
              },
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${commandName ?? "output will show up here"}',
                    style: TextStyle(
                      //decoration: BoxDecoration().borderRadius,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
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
