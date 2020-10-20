import 'package:BugReport/provider/bug_provider.dart';
import 'package:BugReport/screens/list_bugs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BugProvider(),
      child: MaterialApp(
        title: "Bug App",
        debugShowCheckedModeBanner: false,
        home: ListBugs(),
      ),
    );
  }
}
