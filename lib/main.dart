// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qal_web_admin/Agents/agentDash.dart';
import 'package:qal_web_admin/Dashboard/Clients.dart';
import 'package:qal_web_admin/Consts/Const.dart';
import 'Dashboard/Dash.dart';
import 'LoginApp.dart';
import 'Splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    
      routes: {
   
     "/": (context) => const LoginApp(),   

      },
    );
  }
}
