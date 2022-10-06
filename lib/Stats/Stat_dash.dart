// ignore_for_file: file_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qal_web_admin/Consts/Const.dart';

import '../Dashboard/Prestataires/addpresta.dart';
import 'Statclass.dart';

class Statistiques extends StatefulWidget {
  const Statistiques({
    Key? key,
  }) : super(key: key);

  @override
  State<Statistiques> createState() => _StatistiquesState();
}

class _StatistiquesState extends State<Statistiques> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
        const SizedBox(height: 16.0),
        GridView.builder(
            shrinkWrap: true,
            itemCount: statItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio:4,
                crossAxisCount: 3,
                crossAxisSpacing: 26.0),
            itemBuilder: (context, index) => StatCard(
                  info: statItems[index],
                )),
                SizedBox(height:20),
        GridView.builder(
            shrinkWrap: true,
            itemCount: reqStat.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio:6,
                crossAxisCount: 3,
                crossAxisSpacing: 26.0),
            itemBuilder: (context, index) => ReqStat(
                  info: reqStat[index],
                )),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({Key? key, required this.info}) : super(key: key);
  final StatManage info;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:info.color,
      child: ListTile(
        style:ListTileStyle.drawer,
        title:Text(info.title.toString(),style:TextStyle(fontSize:22)),
        trailing:Text(info.nombre.toString(),style:TextStyle(fontSize:22, color:Colors.white)),
      ),
    );
  }
}
class ReqStat extends StatelessWidget {
  const ReqStat({Key? key, required this.info}) : super(key: key);
  final RequestManage info;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:info.reqcolor,
      child: ListTile(
        style:ListTileStyle.drawer,
        title:Text(info.reqtitle.toString(),style:TextStyle(fontSize:22,color:Color.fromARGB(172, 0, 0, 0))),
        trailing:Text(info.reqnums.toString(),style:TextStyle(fontSize:22, color:Colors.green)),
      ),
    );
  }
}
