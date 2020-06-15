import 'package:flutter/material.dart';
import 'package:applicationdefluxrss/widgets/my_app.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';



void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  runApp(MyApp());
}




