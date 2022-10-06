// ignore_for_file: file_names, use_build_context_synchronously
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qal_web_admin/Consts/Const.dart';
import 'package:qal_web_admin/Host.dart';

class Cmdencours extends StatefulWidget {
  const Cmdencours({Key? key}) : super(key: key);
  static const String id='cmdC_screen';
  @override
  State<Cmdencours> createState() => CmdencoursState();
}

class CmdencoursState extends State<Cmdencours> {
  List cmdCrs = [];



     Future getApiData() async {
    try {
      var url = "${Host.hostlink}/cmdcours.php";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          cmdCrs = jsonDecode(response.body);
        });
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
    }
  }
 

  Future rechercher({required String search}) async {
    print('Search');
    setState(() {
      cmdCrs = [];
    });
    try {
      var url = "${Host.hostlink}/Search.php";
      final response = await http.post(Uri.parse(url), body: {
        'searchtxt': search,
      });
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        setState(() {
          cmdCrs = jsondata;
        });
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
    }
  }
  Future validcmd({required String idcmd}) async {
    try {
      var url = "${Host.hostlink}/validcmd.php";
      final response = await http.post(Uri.parse(url), body: {
        'idcmd': idcmd,
      });
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if(jsondata==0){
         setState(() {
             getApiData();
          Flushbar(
                backgroundColor: Colors.green.shade400,
                flushbarPosition: FlushbarPosition.TOP,
                title: "Inscription",
                message:'Commande validé avec succès',
                duration: const Duration(seconds: 5),
              ).show(context);
         });
        }
        else
        {
          Flushbar(
                backgroundColor: Colors.red.shade400,
                flushbarPosition: FlushbarPosition.TOP,
                title: "Inscription",
                message: 'Erreur de validation de pour cette commande',
                duration: const Duration(seconds: 5),
              ).show(context);
        }
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
    }
  }
  TextEditingController motif=TextEditingController();
  Future decline({required String idcmd,required String motif}) async {
    try {
      var url = "${Host.hostlink}/declineCmd.php";
      final response = await http.post(Uri.parse(url), body: {
        'idcmd': idcmd,
        'motif': motif,
      });
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if(jsondata==0){
         setState(() {
             getApiData();
          Flushbar(
                backgroundColor: Colors.blue.shade400,
                flushbarPosition: FlushbarPosition.TOP,
                title: "Inscription",
                message:'Commande refusé ',
                duration: const Duration(seconds: 5),
              ).show(context);
         });
        }
        else
        {
          Flushbar(
                backgroundColor: Colors.red.shade400,
                flushbarPosition: FlushbarPosition.TOP,
                title: "Inscription",
                message: 'Erreur de refus de pour cette commande',
                duration: const Duration(seconds: 5),
              ).show(context);
        }
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
    }
  }



  TextEditingController searchtxt = TextEditingController();
  final recherche = GlobalKey<FormState>();
  DropdownMenuItem<String> buildItems(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
      ),
    );
  }

  final rechAv = GlobalKey<FormState>();
 

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                height: (MediaQuery.of(context).size.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Listes",
                          style: TextStyle(
                              fontSize: 20, color: Appcolor.secondarycolor),
                        ),
                        Recherhe(),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    (cmdCrs.isNotEmpty)
                        ? Center(
                            child: (cmdCrs[0] != "Empty")
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                        border: TableBorder.all(color:Color.fromARGB(157, 0, 0, 0)),
                                        dataTextStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                       // columnSpacing: 30,
                                        columns:colonnes(),
                                        rows: List.generate(
                                            cmdCrs.length,
                                            (index) =>
                                                prestfiledata(cmdCrs, index,(){
                                                    showDialog(
                                                      context: context,
                                                      builder: ((context) {
                                                        return CupertinoAlertDialog(
                                                          title:
                                                              const Text("Accept ?"),
                                                          content: Text(
                                                              "Valider la commande de ${cmdCrs[index]['nomprenom']}  ?"),
                                                          actions: [
                                                            CupertinoActionSheetAction(
                                                                onPressed:
                                                                    () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                child:const Text(
                                                                    "Non")),
                                                            CupertinoActionSheetAction(
                                                                onPressed:
                                                                    () {
                                                                      validcmd(idcmd:'${cmdCrs[index]['Idcmd']}');
                                                                      Navigator.pop(context);
                                                                    },
                                                                child:const Text(
                                                                    "Oui")),
                                                          ],
                                                        );
                                                      }));
                                                },
                                                (){
                                                   showDialog(
                                                      context: context,
                                                      builder: ((context) {
                                                        return  AlertDialog(
                                                          titleTextStyle:const TextStyle(color:Colors.black),
                                                          contentTextStyle:const TextStyle(color:Colors.black),
                                                          title:const Text("Motif",style:TextStyle(fontSize:22),),
                                                          content:Container(
                                                            width:200,
                                                            decoration:BoxDecoration(
                                                              color:Colors.black12,
                                                              borderRadius:BorderRadius.circular(10),
                                                              border:Border.all(color:Colors.black12)
                                                            ),
                                                            child: TextFormField(
                                                              maxLines:5,
                                                              controller:motif,
                                                              style:const TextStyle(color:Colors.black),
                                                              decoration:const InputDecoration(
                                                                contentPadding:EdgeInsets.all(8),
                                                               border:InputBorder.none,
                                                               hintText:'Ecrire le motif ...',
                                                              ),
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(onPressed:(){
                                                             decline(idcmd:'${cmdCrs[index]['Idcmd']}',motif:motif.text);
                                                              Navigator.pop(context);
                                                              getApiData();
                                                              print(motif.text);
                                                            }, child:const Text("Valider")),
                                                            TextButton(onPressed:(){
                                                              Navigator.pop(context);
                                                            }, child:const Text("Annuler")),
                                                          ],
                                                        );
                                                      })
                                                      );
                                                }
                                                ),
                                                )
                                                ),
                                  )
                                : const Text("AUCUNE CORRESPONDANCE",
                                    style: TextStyle(color: Colors.red)),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                                color: Appcolor.bgColor))
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ));
  }

  Widget Recherhe() => Padding(
      padding: const EdgeInsets.only(left: 35.0),
      child: Container(
        width: 295,
        height: 37,
        decoration: BoxDecoration(
          color: const Color.fromARGB(217, 255, 82, 82),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Form(
          key: recherche,
          child: TextField(
            controller: searchtxt,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(5),
              hintText: 'Rechercher un prestataire',
              border: InputBorder.none,
              hintStyle:
                  const TextStyle(color: Color.fromARGB(149, 239, 234, 234)),
              // fillColor:Appcolor.bgColor,
              labelStyle:
                  const TextStyle(color: Color.fromARGB(178, 33, 35, 50)),
              //   filled:true,
              suffixIcon: IconButton(
                onPressed: () {
                  if (searchtxt.text.isNotEmpty) {
                    rechercher(search: searchtxt.text);
                  }
                },
                icon: const Icon(Icons.search),
                color: const Color.fromARGB(149, 239, 234, 234),
              ),
            ),
          ),
        ),
      ));
}

DataRow prestfiledata(List cmdCrs, int index,void Function()? valid,void Function()? decline) {
  return DataRow(
    cells: [
      DataCell(Text('${cmdCrs[index]['Idcmd']}')),
      DataCell(Text(cmdCrs[index]['nomprenom'])),
      DataCell(Text(cmdCrs[index]['nomcomplet_prest'])),
      DataCell(Text(cmdCrs[index]['Lib_serv'])),
      DataCell(Text(cmdCrs[index]['duree'])),
      DataCell(Text(cmdCrs[index]['statut'])),
      DataCell(Text('${cmdCrs[index]['contratFile']}')),
         DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed:valid,
                child: Text('Valider'),
                style: ElevatedButton.styleFrom(primary: Colors.green[400]),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed:decline,
                child:  Text('Decliner'),
                style: ElevatedButton.styleFrom(primary: const Color.fromARGB(217, 255, 82, 82),),
              )),
        ],
      )),
      
    ],
  );
}
List<DataColumn> colonnes(){
  return const[
      DataColumn(
                                              label: Text(
                                            "Id_commande",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Client",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Prestataires",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Service",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "durée",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            " statut",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "File",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Actions",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
  ];
}
