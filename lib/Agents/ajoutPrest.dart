import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qal_web_admin/Agents/glovalVar.dart';
import 'package:qal_web_admin/Agents/imagepick.dart';
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
  int? servValue;
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
    final response =
        await http.get(Uri.parse('http://localhost/qal_app/Web/getNiveau.php'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        nivList = data;
      });
    }
    return "succes";
  }

  Future getEth() async {
    final response =
        await http.get(Uri.parse('http://localhost/qal_app/Web/getEthnie.php'));
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
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numerocontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
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
    });
  }

  List prestList = [];
  Future getList() async {
    final response = await http
        .get(Uri.parse('http://localhost/qal_app/Web/getPrestataire.php'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        prestList = data;
      });
    }
  }

  DataTable dataprestlist() {
    return DataTable(
        headingTextStyle:
            TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        dataTextStyle: TextStyle(color: Colors.black),
        columns: const [
          DataColumn(
            label: Text('Matricule'),
            numeric: true,
          ),
          DataColumn(
            label: Text('Nom'),
            numeric: false,
          ),
          DataColumn(
            label: Text('Contact'),
            numeric: false,
          ),
          DataColumn(
            label: Text('Service'),
            numeric: false,
          ),
          DataColumn(
            label: Text('Nationalité'),
            numeric: false,
          ),
          DataColumn(
            label: Text('Commune'),
            numeric: false,
          ),
          DataColumn(
            label: Text('Ethnie'),
            numeric: false,
          ),
          DataColumn(
            label: Text('Réligion'),
            numeric: false,
          ),
          DataColumn(
            label: Text('Actions'),
            numeric: false,
          ),
        ],
        rows: List.generate(prestList.length, (index) {
          return DataRow(cells: [
            DataCell(Text('${index+1}')),
            DataCell(Text(prestList[index]['nomcomplet_prest'])),
            DataCell(Text(prestList[index]['contact_prest'])),
            DataCell(Text(prestList[index]['Lib_serv'])),
            DataCell(Text(prestList[index]['nationalite_prest'])),
            DataCell(Text(prestList[index]['commune_prest'])),
            DataCell(Text(prestList[index]['ethnie_prest'])),
            DataCell(Text(prestList[index]['religion_prest'])),
            DataCell(Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                        showDialog(
                          context: context, 
                          builder:((context) {
                            return AlertDialog(
                              title: Text('Suppression',style:TextStyle(color:Colors.black)),
                              content:Text("Voulez-vous supprimer ${prestList[index]['nomcomplet_prest']}",style:TextStyle(color:Colors.black)),
                              actions: [
                                TextButton(onPressed:(){
                                  CloseButton();
                                }, child: Text("Annuler")),
                                TextButton(onPressed:(){
                                   delete(idprest: prestList[index]['Mat_prest']);
                                }, child: Text('delete'))
                              ],
                            );
                          })
                          );
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('delete')),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(onPressed: () {}, child: Text('editer'),),
              ],
            )),
          ]);
        }));
  }

  ////API D'INSERTION
 Future insertdata({
    required String name,
    required String service,
    required String? email,
    required String contact,
    required String birthday,
    required String commune,
    required String ethnie,
    required String religion,
    required String nationalite,
    required String nivetude,
    required String pass, 
    required String img, 
  }) async {
    try {
      const url = '${Host.hostlink}/inscriptPrest.php';
      final response = await http.post(Uri.parse(url), body: {
       'name':name,
       'service':service,
       'email':email,
       'contact':contact, 
       'birthday':birthday,
       'commune':commune,
       'ethnie':ethnie,
       'religion':religion,
       'nationalite':nationalite,
       'nivetude':nivetude,
       'pass':pass,
       'image':img,
      });
      print(namecontroller.text);
      print(serLib);
      print(emailcontroller.text);
      print(numerocontroller.text);
      print(birthcontroller.text);
      print(libcommune);
      print(libethnie);
      print(relLib);
      print(natLib);
      print(nivlib);
      print(passcontroller.text);
      print(webimage);

      if (response.statusCode == 200) {
        var jsondecode = jsonDecode(response.body); 
        var outnum = jsondecode[0];
        if (outnum == 0) {
          print(jsondecode[1]);
         setState(() {
            getList();
            namecontroller.text='';
            birthcontroller.text='';
            emailcontroller.text='';
            numerocontroller.text='';
            passcontroller.text='';
            libcommune=null;
            serLib=null;
            libethnie=null;
            relLib=null;
            natLib=null;
            nivlib=null;
            imgfile=null;
            servValue=null;
         });
        } else {
            print(jsondecode[1]);
        }
      }
    } catch (e) {
      debugPrint('Dart ::: ${e.toString()}');
    }
  }
    Future delete({required String idprest}) async {
    print('Delete');
    try {
      var url = "${Host.hostlink}/deletePrest.php";
      final response = await http.post(Uri.parse(url), body: {
        'idprest': idprest,
      });
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if(jsondata==0){
          setState(() {
            debugPrint('Json data =$jsondata');
            getList();
          });
        }
        else
        {
          print("Erreur de suppression ");
        }
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
    }
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
        body: SingleChildScrollView(
          child: Column(
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
                        onPressed: () {
                        insertdata(name: namecontroller.text, service:servValue.toString(), email: emailcontroller.text, contact: numerocontroller.text, birthday: birthcontroller.text, commune: libcommune!, ethnie: libethnie!, religion: relLib!, nationalite: natLib!, nivetude:nivlib!, pass: passcontroller.text, img: webimage.toString());
                        },
                        icon: Icon(Icons.add),
                        label: Text('AJOUTER'))
                  ],
                ),
              ),
              PickImages(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    formAdd(
                        hint: 'Nom complet ', icon: Icons.person, enable: true,controller:namecontroller),
                    servList(hint: 'Service'),
                    formAdd(
                        hint: 'Adresse email (facultatif)',
                        icon: Icons.mail,
                        enable: true,controller:emailcontroller),
                    formAdd(hint: 'Contact', icon: Icons.phone, enable: true,controller:numerocontroller),
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
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      natdrop(hint: 'Nationalité'),
                      nivdrop(hint: 'Niveau d\' Etude'),
                      formAdd(
                          hint: 'Mot de passe ',
                          icon: Icons.security,
                          enable: true,
                          pass: true,controller:passcontroller),
                      formAdd(
                          hint: 'Confirmer le mot de passe ',
                          icon: Icons.security,
                          enable: true,
                          pass: true),
                    ],
                  )),
              Divider(),
              dataprestlist()
            ],
          ),
        ));
  }

  Padding formAdd(
      {required IconData icon,
      required String hint,
      bool pass = false,
      TextEditingController? controller,
      required bool enable}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Color.fromARGB(255, 230, 230, 230),
        height: 35,
        width: 300,
        child: TextFormField(
          obscureText: pass,
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

  Padding drop({
    required String hint,
  }) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            height: 35,
            width: 300,
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

  Padding ethniedrop({
    required String hint,
  }) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            height: 35,
            width: 300,
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

  Padding reldrop({
    required String hint,
  }) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            height: 35,
            width: 300,
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

  Padding natdrop({
    required String hint,
  }) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            height: 35,
            width: 300,
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

  Padding nivdrop({
    required String hint,
  }) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            height: 35,
            width: 300,
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

  Padding servList({
    required String hint,
  }) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            height: 35,
            width: 300,
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
                      onTap:(){
                        setState(() {
                          servValue=e['Numserv'];
                        });
                      },
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
