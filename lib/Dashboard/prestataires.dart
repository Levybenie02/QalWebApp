// ignore_for_file: file_names

import 'package:flutter/material.dart';
class PrestScreen extends StatefulWidget {
  const PrestScreen({Key? key}) : super(key: key);
    static const String id='prest_screen';

  @override
  State<PrestScreen> createState() => _PrestScreenState();
}

class _PrestScreenState extends State<PrestScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Prestataires',style:TextStyle(fontSize: 30)),);
  }
}