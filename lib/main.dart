import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weltraum_einwanderer/pages/startpage.dart';

void main() {
  runApp(
    MaterialApp(
      home: StartPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
