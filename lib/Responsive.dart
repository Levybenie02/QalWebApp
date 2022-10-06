// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsive({Key? key,required this.mobile,required this.tablet,required this.desktop}) : super(key: key);

  static bool isMobile(BuildContext context){
   return MediaQuery.of(context).size.width<850.0;
  }
  static bool isTablet(BuildContext context){
    return MediaQuery.of(context).size.width<1100.0 &&
     MediaQuery.of(context).size.width>=850.0;
  }

  static bool isDesktop(BuildContext context){
    return      MediaQuery.of(context).size.width>=1100.0;

  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    if(size.width>=1100){
      return desktop;
    }
    else if(size.width>=850){
      return tablet;
    }
    else{
      return mobile;
    }
  }
}