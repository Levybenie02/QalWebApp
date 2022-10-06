// ignore_for_file: file_names

import 'package:flutter/material.dart';

 class StatManage{
    String? title;
    String? nombre;
    Color? color;

    StatManage(this.title,this.nombre,this.color);
 }
 List statItems=[
   StatManage('Nombre de requêtes', '0',const Color.fromARGB(255, 28, 49, 66),), 
   StatManage('Nombres de clients', '274',Colors.blueGrey),
   StatManage('Nombre de prestataires', '142',Colors.grey),
 ];
 class RequestManage{
    String? reqtitle;
    String? reqnums;
    Color? reqcolor;

    RequestManage(this.reqtitle,this.reqnums,this.reqcolor);
 }
 List reqStat=[
   RequestManage('Requête validée', '500',Color.fromARGB(152, 255, 255, 255),),
   RequestManage('Requête en attente', '274',Color.fromARGB(152, 255, 255, 255)),
   RequestManage('Requête rejetée', '142',Color.fromARGB(152, 255, 255, 255)),
 ];