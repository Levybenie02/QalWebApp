// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qal_web_admin/Consts/Const.dart';
import 'package:qal_web_admin/Host.dart';

class Cmdvalid extends StatefulWidget {
  const Cmdvalid({Key? key}) : super(key: key);
  static const String id='cmdV_screen';
  @override
  State<Cmdvalid> createState() => CmdvalidState();
}

class CmdvalidState extends State<Cmdvalid> {
  List cmdAtt = [];



     Future getApiData() async {
    try {
      var url = "${Host.hostlink}/Cmdvalid.php";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          cmdAtt = jsonDecode(response.body);
          debugPrint(cmdAtt.length.toString());
        });
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
    }
  }
 

  Future rechercher({required String search}) async {
    print('Search');
    setState(() {
      cmdAtt = [];
    });
    try {
      var url = "${Host.hostlink}/Search.php";
      final response = await http.post(Uri.parse(url), body: {
        'searchtxt': search,
      });
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        setState(() {
          cmdAtt = jsondata;
        });
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
    }
  }



  TextEditingController searchtxt = TextEditingController();
  final recherche = GlobalKey<FormState>();

  final service = ['Service', 'Servante', 'Nounou', 'Fanico'];
  final nationalite = ['Nationalité', 'Ivoirienne', 'Malienne', 'Burkinabée'];
  final communne = ['Commune', 'Yopougon', 'Macory', 'Koumassi'];
  final ethnie = ['Ethnie', 'Agni', 'Baoulé', 'Gouro'];
  final religion = ['Réligion', 'Chrétienne', 'Musulmanne', 'Aucune'];
  String? valueS;
  String? valueC;
  String? valueN;
  String? valueE;
  String? valueR;
  String value1 = '';
  String value2 = '';
  String value3 = '';
  String value4 = '';
  String value5 = '';
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
                    (cmdAtt.isNotEmpty)
                        ? Center(
                            child: (cmdAtt[0] != "Empty")
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                        border: TableBorder.all(),
                                        dataTextStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        columnSpacing: 30,
                                        columns:colonnes(),
                                        rows: List.generate(
                                            cmdAtt.length,
                                            (index) =>
                                                prestfiledata(cmdAtt, index),
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

DataRow prestfiledata(List cmdAtt, int index) {
  return DataRow(
    cells: [
      DataCell(Text('${cmdAtt[index]['Idcmd']}')),
      DataCell(Text(cmdAtt[index]['nomprenom'])),
      DataCell(Text(cmdAtt[index]['nomcomplet_prest'])),
      DataCell(Text(cmdAtt[index]['Lib_serv'])),
      DataCell(Text(cmdAtt[index]['duree'])),
      DataCell(Text(cmdAtt[index]['statut'])),
      DataCell(Text('${cmdAtt[index]['contratFile']}')),
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
  ];
}
