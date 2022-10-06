import 'package:flutter/material.dart';


 Container boxstatcont({required String title, required int? data, required Color? color }){
      return Container(
                    width:100,
                    height:90,
                    decoration:BoxDecoration(
                      color:color
                    ),
                    child:Center(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(title,style:TextStyle(fontSize:20,color:Colors.black),)),
                           Text(data.toString(),style:TextStyle(fontSize:20,color:Colors.black87)),
                          
                        ],
                      ),
                    ),
                  );
    }