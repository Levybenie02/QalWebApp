import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qal_web_admin/Consts/Const.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:qal_web_admin/Host.dart';

class agentAdd extends StatefulWidget {
  const agentAdd({super.key});

  @override
  State<agentAdd> createState() => agentAddState();
}

class agentAddState extends State<agentAdd> {
  List comList = [];
  List ethList = [];
  List relList = [];
  List natList = [];
  List nivList = [];
  List serList = [];
  String? libcommune;
  String? libethnie;
  String? nivlib;
  String? relLib;
  String? natLib;
  String? livLib;
  String? serLib;
  Future getComm() async {
    final response = await http
        .get(Uri.parse('http://localhost/qal_app/Web/getCommune.php'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        comList = data;
      });
    }
    return "succes";
  }
  Future getNat() async {
    final response = await http
        .get(Uri.parse('http://localhost/qal_app/Web/getNationalite.php'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        natList = data;
      });
    }
    return "succes";
  }
  Future getServ() async {
    final response = await http
        .get(Uri.parse('http://localhost/qal_app/Web/getService.php'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        serList = data;
      });
    }
    return "succes";
  }
  Future getNiv() async {
    final response = await http
        .get(Uri.parse('http://localhost/qal_app/Web/getNiveau.php'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        nivList = data;
      });
    }
    return "succes";
  }
   Future getEth() async {
    final response = await http
        .get(Uri.parse('http://localhost/qal_app/Web/getEthnie.php'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        ethList = data;
      });
    }
    return "succes";
  }
    Future getRel() async {
    final response = await http
        .get(Uri.parse('http://localhost/qal_app/Web/getReligion.php'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        relList = data;
      });
    }
    return "succes";
  }

  DateTime date = DateTime.now();
  TextEditingController birthcontroller = TextEditingController();
  showpickerdate(BuildContext context) async {
    DateTime? newdate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (newdate == null) return;
    setState(() {
      date = newdate;
      birthcontroller.text = DateFormat('dd-MM-yyyy').format(newdate);
      debugPrint(birthcontroller.text);
    });
  }
    List prestList=[];
  Future getList() async{
    final response=await http
        .get(Uri.parse('http://localhost/qal_app/Web/getPrestataire.php'));
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      prestList=data;
    }
  }
  DataTable dataprestlist(){
    return DataTable(
      
      headingTextStyle:TextStyle(color:Colors.blue,fontWeight:FontWeight.bold),
      dataTextStyle:TextStyle(color:Colors.black),
      columns:const[
        DataColumn(label:Text('Matricule'),numeric:false,tooltip:'Matricule'),
        DataColumn(label:Text('Nom'),numeric:false,tooltip:'Nom'),
        DataColumn(label:Text('Contact'),numeric:false,tooltip:'Contact'),
        DataColumn(label:Text('Service'),numeric:false,tooltip:'Service'),
        DataColumn(label:Text('Nationalité'),numeric:false,tooltip:'Nationalite'),
        DataColumn(label:Text('Commune'),numeric:false,tooltip:'Commune'),
        DataColumn(label:Text('Ethnie'),numeric:false,tooltip:'Ethnie'),
        DataColumn(label:Text('Réligion'),numeric:false,tooltip:'Religion'),
        DataColumn(label:Text('Actions'),numeric:false,tooltip:'Actions'),
      ], 
      rows:List.generate(prestList.length, (index){
        return DataRow(
          cells:[
            DataCell(Text(prestList[index]['Mat_prest'])),
            DataCell(Text(prestList[index]['nomcomplet_prest'])),
            DataCell(Text(prestList[index]['contact_prest'])),
            DataCell(Text(prestList[index]['Lib_serv'])),
            DataCell(Text(prestList[index]['nationalite_prest'])),
            DataCell(Text(prestList[index]['commune_prest'])),
            DataCell(Text(prestList[index]['ethnie_prest'])),
            DataCell(Text(prestList[index]['religion_prest'])),
            DataCell(Row(
              children: [
                TextButton(onPressed:(){}, child: Text('delete')),
                TextButton(onPressed:(){}, child: Text('editer')),
              ],
            )),
          ]
        );
      })
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComm();
    getEth();
    getRel();
    getNat();
    getNat();
    getNiv();
    getList();
    getServ();
  }

  @override
  Widget build(BuildContext context) {
    Color colorApp = Colors.blue;
    Color heardcolor = Colors.black;
    double fontsiz = 15.0;
    var dataRow = DataRow(cells: [
      DataCell(Center(
          child: Text("data",
              style: TextStyle(color: heardcolor, fontSize: fontsiz)))),
      DataCell(Center(
          child: Text("data",
              style: TextStyle(color: heardcolor, fontSize: fontsiz)))),
      DataCell(Center(
          child: Text("data",
              style: TextStyle(color: heardcolor, fontSize: fontsiz)))),
      DataCell(Center(
          child: Text("data",
              style: TextStyle(color: heardcolor, fontSize: fontsiz)))),
      DataCell(Center(
          child: Text("data",
              style: TextStyle(color: heardcolor, fontSize: fontsiz)))),
      DataCell(Center(
          child: Icon(
        Icons.edit,
        color: Colors.blue,
      ))),
      DataCell(Center(child: Icon(Icons.delete, color: Colors.red))),
    ]);
    return Scaffold(
        backgroundColor: Colors.white10,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ajouter un prestataire",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      label: Text('AJOUTER'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  formAdd(hint: 'Nom complet ', icon: Icons.person, enable: true),
                  servList(hint:'Service'),

                  formAdd(
                      hint: 'Adresse email (facultatif)',
                      icon: Icons.mail,
                      enable: true),
                  formAdd(hint: 'Contact', icon: Icons.phone, enable: true),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        showpickerdate(context);
                      },
                      child: formAdd(
                          icon: Icons.date_range,
                          hint: 'Date de naissance',
                          enable: false,
                          controller: birthcontroller)),
                  drop(hint: 'Commune de résidence'),
                  ethniedrop(hint: 'Ethnie'),
                  reldrop(hint: 'Religion'),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.all(8.0),
              child:Row(
                children: [
                  natdrop(hint: 'Nationalité'),
                  nivdrop(hint: 'Niveau d\' Etude'),
                 formAdd(hint: 'Mot de passe ', icon: Icons.security, enable: true,pass:true),
                 formAdd(hint: 'Confirmer le mot de passe ', icon: Icons.security, enable: true,pass:true),

                ],
              )
            ),
            Divider(),

            dataprestlist()
          ],
        ));
  }

  Padding formAdd(
      {required IconData icon,
      required String hint,
      bool pass=false,
      TextEditingController? controller,
      required bool enable}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Color.fromARGB(255, 230, 230, 230),
        height: 35,
        width: 300,
        child: TextFormField(
          obscureText:pass,
          controller: controller,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            enabled: enable,
            prefixIcon: Icon(icon),
            hintText: hint,
          ),
        ),
      ),
    );
  }

  Padding drop(
      {required String hint,
      }) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            height: 35,
            width:300,
            child: Center(
              child: DropdownButton(
                  underline: Container(),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  hint: Text(hint),
                  value: libcommune,
                  items: comList.map((e) {
                    return DropdownMenuItem(
                      value: e['libelle'],
                      child: Text(e['libelle']),
                    );
                  }).toList(),
                  onChanged: ((value) { 
                    setState(() {
                      libcommune = value as String?;
                    });
                  })),
            )));
  }
  
    Padding ethniedrop(
      {required String hint,
      }) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            height: 35,
            width:300,
            child: Center(
              child: DropdownButton(
                  underline: Container(),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  hint: Text(hint),
                  value: libethnie,
                  items: ethList.map((e) {
                    return DropdownMenuItem(
                      value: e['libelle'],
                      child: Text(e['libelle']),
                    );
                  }).toList(),
                  onChanged: ((value) { 
                    setState(() {
                      libethnie = value as String?;
                    });
                  })),
            )));
  }
   Padding reldrop(
      {required String hint,
      }) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            height: 35,
            width:300,
            child: Center(
              child: DropdownButton(
                  underline: Container(),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  hint: Text(hint),
                  value: relLib,
                  items: relList.map((e) {
                    return DropdownMenuItem(
                      value: e['libelle'],
                      child: Text(e['libelle']),
                    );
                  }).toList(),
                  onChanged: ((value) { 
                    setState(() {
                      relLib = value as String?;
                    });
                  })),
            )));
  }
    Padding natdrop(
      {required String hint,
      }) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            height: 35,
            width:300,
            child: Center(
              child: DropdownButton(
                  underline: Container(),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  hint: Text(hint),
                  value: natLib,
                  items: natList.map((e) {
                    return DropdownMenuItem(
                      value: e['libelle'],
                      child: Text(e['libelle']),
                    );
                  }).toList(),
                  onChanged: ((value) { 
                    setState(() {
                      natLib = value as String?;
                    });
                  })),
            )));
  }
   Padding nivdrop(
      {required String hint,
      }) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            height: 35,
            width:300,
            child: Center(
              child: DropdownButton(
                  underline: Container(),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  hint: Text(hint),
                  value: nivlib,
                  items: nivList.map((e) {
                    return DropdownMenuItem(
                      value: e['libelle'],
                      child: Text(e['libelle']),
                    );
                  }).toList(),
                  onChanged: ((value) { 
                    setState(() {
                      nivlib = value as String?;
                    });
                  })),
            )));
  }
  Padding servList(
      {required String hint,
      }) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            height: 35,
            width:300,
            child: Center(
              child: DropdownButton(
                  underline: Container(),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  hint: Text(hint),
                  value: serLib,
                  items: serList.map((e) {
                    return DropdownMenuItem(
                      value: e['Lib_serv'],
                      child: Text(e['Lib_serv']),
                    );
                  }).toList(),
                  onChanged: ((value) { 
                    setState(() {
                      serLib = value as String?;
                    });
                  })),
            )));
  }

}

