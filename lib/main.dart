// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qal_web_admin/Agents/agentDash.dart';
import 'package:qal_web_admin/Dashboard/Clients.dart';
import 'package:qal_web_admin/Consts/Const.dart';
import 'Dashboard/Dash.dart';
import 'LoginApp.dart';

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
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor:Appcolor.bgColor,
        textTheme:GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor:Colors.white),
        canvasColor:Color.fromARGB(255, 183, 184, 185),
      ),
      routes: {
     //"/": (context) => const Splashscreen(),
   //  "/": (context) =>  AgtDashboard(), 
   // "/": (context) => const Dashboard(), 
      "/": (context) => const LoginApp(),   

      },
    );
  }
}
