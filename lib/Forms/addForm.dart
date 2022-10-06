import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qal_web_admin/Consts/Const.dart';
import 'package:http/http.dart' as http;
import '../Host.dart';

class Addforms extends StatefulWidget {
Addforms({this.value1,this.value2,this.value3,this.value4,this.value5,this.value6,this.value7,this.value8,this.value9});
final  value1, value2, value3,value4,value5,value6,value7,value8,value9;

  @override
  State<Addforms> createState() => _AddformsState();
}

class _AddformsState extends State<Addforms> {
  String ?id;
  TextEditingController nomcontroller=TextEditingController();
  TextEditingController contactcontroller=TextEditingController();
  TextEditingController servicecontroller=TextEditingController();
  TextEditingController natcontroller=TextEditingController();
  TextEditingController comcontroller=TextEditingController();
  TextEditingController ethcontroller=TextEditingController();
  TextEditingController relcontroller=TextEditingController();
  TextEditingController statutcontroller=TextEditingController();

     Future getApiData() async {
       setState(() {
         datax=[];
       });
    try {
      var url = "${Host.hostlink}/getPrestataire.php";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          datax = jsonDecode(response.body);
        });
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
    }
  }
    Future update({required String idprest,required String nom,required String contact,required String servic,required String nationalit,required String commune,required String ethni,
  required String relig,required String statut
  }) async {
    setState(() {
      datax=[];
    });
    print('UPDATE PROCES');

    try {
      var url = "${Host.hostlink}/update.php";
      final response = await http.post(Uri.parse(url), body: {
        'idprest': idprest,
        'nom':nom,
        'contact':contact,
        'service':servic,
        'nationalite':nationalit,
        'commune':commune,
        'ethnie':ethni,
        'religion':relig,
        'statut':statut,
      });
      if (response.statusCode == 200) {
        print('Response obtaind');
        var jsondata = (response.body);
        if(jsondata==0){
            print('Update succesfull  =$jsondata');
            getApiData();
            Navigator.pop(context);
        }
        else
        {
          print("Erreur de maj $jsondata");
        }
      }
    } catch (e) {
      debugPrint("Exception catch:$e");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id=widget.value1;
    nomcontroller.text=widget.value2;
    contactcontroller.text=widget.value3;
    servicecontroller.text=widget.value4;
    natcontroller.text=widget.value5;
    comcontroller.text=widget.value6;
    ethcontroller.text=widget.value7; 
    relcontroller.text=widget.value8;
    statutcontroller.text=widget.value9;
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle:const TextStyle(color:Colors.black,fontSize:21),
      contentTextStyle:const TextStyle(color:Colors.black),
      title:const Text('Modification'),
      content:Container(
        width:300,
        child: Column(
          children: [
          formsfield(hint:'Nom & Prénom',textcontroller:nomcontroller),
          formsfield(hint:'Contact',textcontroller:contactcontroller),
          formsfield(hint:'Service',textcontroller:servicecontroller),
          formsfield(hint:'Nationalité',textcontroller:natcontroller),
          formsfield(hint:'Commune',textcontroller:comcontroller),
          formsfield(hint:'Ethnie',textcontroller:ethcontroller),
          formsfield(hint:'Religion',textcontroller:relcontroller),
          formsfield(hint:'Statut',textcontroller:statutcontroller),
          ],
        ),
      ),
      actions: [
        TextButton.icon(onPressed:(){
          (servicecontroller.text=='Servante')?
          servicecontroller.text='1':  
          (servicecontroller.text=='Nounou')? 
          servicecontroller.text='2' :  
          (servicecontroller.text=='Fanico')? 
          servicecontroller.text='3':servicecontroller.text='';
          update(idprest:id!, nom: nomcontroller.text, contact: contactcontroller.text, servic: servicecontroller.text, nationalit: natcontroller.text, commune: comcontroller.text, ethni: ethcontroller.text, relig: relcontroller.text, statut: statutcontroller.text);
          Navigator.pop(context);
        }, icon:const Icon(Icons.check,color:Colors.blue,), label:const Text("Valider",style:TextStyle(color:Colors.blue),)),
        TextButton.icon(onPressed:(){
          Navigator.pop(context);
        }, icon:const Icon(Icons.close,color: Color.fromARGB(217, 255, 82, 82),), label:const Text("Annuler",style:TextStyle(color: Color.fromARGB(217, 255, 82, 82),),)),
      ],
    );
  }
 
}