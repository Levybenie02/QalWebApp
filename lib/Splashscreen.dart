import 'dart:async';

import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
       const Duration(seconds:5),
        () =>  Navigator.pushReplacementNamed(context, "loginpage"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'Images/Qal2.png',
                height: 200,
              ),
           /*    SpinKitThreeInOut(
                size:30.0,
                color:Appcolor.orangecolor,
              ) */
            ],
          ),
        )
    );
  }
}