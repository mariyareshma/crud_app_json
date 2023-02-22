import 'package:flutter/material.dart';

import 'view/home_page.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const HomePage(),
    );
  }
}
