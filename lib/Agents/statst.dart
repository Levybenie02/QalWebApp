import 'package:flutter/material.dart';
import 'package:qal_web_admin/Agents/widgetStat.dart';

class StatAgt extends StatefulWidget {
  const StatAgt({super.key});

  @override
  State<StatAgt> createState() => StatAgtState();
}

class StatAgtState extends State<StatAgt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white10,
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
           Row(
             children: [
               Expanded(child: boxstatcont(title:'PRESTATAIRE AJOUTE',data:1, color: Colors.black12,)),SizedBox(width:10,),
               Expanded(child: boxstatcont(title:'PRESTATAIRE SUPPRIME',data:1, color: Colors.black12,)),SizedBox(width:10,),
               Expanded(child: boxstatcont(title:'MES ACTIONS',data:1, color: Colors.redAccent,)),SizedBox(width:10,),
             
             ],
           )
          ],
        ),
      ),
    );
  }
}