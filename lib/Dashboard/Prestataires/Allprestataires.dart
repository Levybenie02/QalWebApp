// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qal_web_admin/Consts/Const.dart';
import 'package:qal_web_admin/Forms/addForm.dart';
import 'package:qal_web_admin/Host.dart';

class Allprestataire extends StatefulWidget {
  const Allprestataire({Key? key}) : super(key: key);
  static const String id='prest_screen';
  @override
  State<Allprestataire> createState() => AllprestataireState();
}

class AllprestataireState extends State<Allprestataire> {
  List dataAllPrest = [];
  List stat = [];
  double st1 = 0;
  double st2 = 0;
  double st3 = 0;
  double cmd1 = 0;
  double cmd2 = 0;


     Future getApiData() async {
    try {
      var url = "${Host.hostlink}/getPrestataire.php";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          dataAllPrest = jsonDecode(response.body);
          debugPrint(dataAllPrest.length.toString());
        });
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
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
            getApiData();
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


  Future statq() async {
    try {
      var url = "${Host.hostlink}/serviceStat.php";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          stat = jsonDecode(response.body);
          st1 = stat[0];
          st2 = stat[1];
          st3 = stat[2];

          cmd1 = stat[3];
          cmd2 = stat[4];
        });
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
    }
  }

  Future rechercher({required String search}) async {
    print('Search');
    setState(() {
      dataAllPrest = [];
    });
    try {
      var url = "${Host.hostlink}/Search.php";
      final response = await http.post(Uri.parse(url), body: {
        'searchtxt': search,
      });
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        setState(() {
          dataAllPrest = jsondata;
        });
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
    }
  }

  Future rechAvance(
    String sertxt,
    String nattxt,
    String comtxt,
    String ethtxt,
    String reltxt,
  ) async {
    print('rech Avance');
    setState(() {
      dataAllPrest = [];
    });
    try {
      var url = "${Host.hostlink}/searchOp.php";
      final response = await http.post(Uri.parse(url), body: {
        'service': sertxt,
        'nationalite': nattxt,
        'commune': comtxt,
        'ethnie': ethtxt,
        'religion': reltxt,
      });
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        setState(() {
          dataAllPrest = jsondata;
          if (dataAllPrest.isNotEmpty) {
            print(dataAllPrest[0]);
          }
        });
      }
    } catch (e) {
      debugPrint("Erreur recherche avance:$e");
    }
  }

  bool hover = false;

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
  Widget searchform(
      {required List<String> lists,
      required String title,
      required String? values}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 170,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Appcolor.secondarycolor,
          border: Border.all(color: Colors.transparent, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
            value: values,
            hint: Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
            items: lists.map(buildItems).toList(),
            onChanged: ((value) {
              return setState(() {
                if (lists == service) {
                  valueS = value;
                  if (valueS != null) {
                    value1 = valueS!;
                    if (valueS == "Service") {
                      valueS = null;
                      getApiData();
                    }
                  }
                } else if (lists == nationalite) {
                  valueN = value;
                  if (valueN != null) {
                    value2 = valueN!;
                    if (valueN == "Nationalité") {
                      valueN = null;
                      getApiData();
                    }
                  }
                } else if (lists == communne) {
                  valueC = value;
                  if (valueC != null) {
                    value3 = valueC!;
                    if (valueC == "Commune") {
                      valueC = null;
                      getApiData();
                    }
                  }
                } else if (lists == religion) {
                  valueR = value;
                  if (valueR != null) {
                    value4 = valueR!;
                    if (valueR == "Réligion") {
                      valueR = null;
                      getApiData();
                    }
                  }
                } else if (lists == ethnie) {
                  valueE = value;
                  if (valueE != null) {
                    value5 = valueE!;
                    if (valueE == "Ethnie") {
                      valueE = null;
                      getApiData();
                    }
                  }
                }
              });
            }),
          ),
        ),
      ),
    );
  }

  Widget searchTile(BuildContext context) {
    return Center(
      child: ExpansionTile(
        title: Text("Recherche Avancée",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blue[600])),
        children: [
          Form(
            key: rechAv,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                searchform(lists: service, title: 'Service', values: valueS),
                searchform(
                    lists: nationalite, title: 'Nationalité', values: valueN),
                searchform(lists: communne, title: 'Commune', values: valueC),
                searchform(lists: ethnie, title: 'Ethnie', values: valueE),
                searchform(lists: religion, title: 'Religion', values: valueR),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        onPrimary: Appcolor.whitecolor,
                        primary: Appcolor.bgColor,
                        minimumSize: const Size(100, 45)),
                    onPressed: () {
                      if (valueC == null &&
                          valueR == null &&
                          valueS == null &&
                          valueE == null &&
                          valueN == null) {
                        null;
                        print('AMpty datta');
                      } else {
                        print('value1 :: $value1');
                        print(value2);
                        print(value3);
                        print(value4);
                        print(value5);

                        rechAvance(
                          value1,
                          value2,
                          value3,
                          value5,
                          value4,
                        );
                      }
                    },
                    icon: const Icon(Icons.remove_red_eye),
                    label: const Text('Afficher')),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        onPrimary: Appcolor.whitecolor,
                        primary:  const Color.fromARGB(217, 255, 82, 82),
                        minimumSize: const Size(100, 45)),
                    onPressed: () {
                      setState(() {
                        getApiData();
                        valueS = null;
                        value1 = '';
                        value2 = '';
                        value3 = '';
                        value4 = '';
                        value5 = '';
                        valueE = null;
                        valueR = null;
                        valueN = null;
                        valueC = null;
                      });
                    },
                    icon: const Icon(Icons.clear),
                    label: const Text('Effacer')),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

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
                    searchTile(context),
                    (dataAllPrest.isNotEmpty)
                        ? Center(
                            child: (dataAllPrest[0] != "Empty")
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
                                            dataAllPrest.length,
                                            (index) =>
                                                prestfiledata(dataAllPrest, index, () {
                                                  print("object");
                                                  showDialog(
                                                      context: context,
                                                      builder: ((context) {
                                                        return CupertinoAlertDialog(
                                                          title:
                                                              const Text("Accept ?"),
                                                          content: Text(
                                                              "Voulez vous supprimer ${dataAllPrest[index]['nomcomplet_prest']} de la liste des prestataires ?"),
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
                                                                      delete(idprest: dataAllPrest[index]['Mat_prest']);
                                                                      Navigator.pop(context);
                                                                    },
                                                                child:const Text(
                                                                    "Oui")),
                                                          ],
                                                        );
                                                      }));
                                                },
                                                 () {
                  showDialog(context: context, builder:((context) {
                    return Addforms(
                        value1:dataAllPrest[index]['Mat_prest'],
                        value2:dataAllPrest[index]['nomcomplet_prest'],
                        value3:dataAllPrest[index]['contact_prest'],
                        value4:dataAllPrest[index]['Lib_serv'],
                        value5:dataAllPrest[index]['nationalite_prest'],
                        value6:dataAllPrest[index]['commune_prest'],
                        value7:dataAllPrest[index]['ethnie_prest'],
                        value8:dataAllPrest[index]['religion_prest'],
                        value9:dataAllPrest[index]['Statut'],
                    );
                  }));
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

DataRow prestfiledata(List dataAllPrest, int index, void Function()? delete,void Function()? edit) {
  return DataRow(
    cells: [
      DataCell(Text(dataAllPrest[index]['Mat_prest'])),
      DataCell(Text(dataAllPrest[index]['nomcomplet_prest'])),
      DataCell(Text(dataAllPrest[index]['contact_prest'])),
      DataCell(Text(dataAllPrest[index]['Lib_serv'])),
      DataCell(Text(dataAllPrest[index]['nationalite_prest'])),
      DataCell(Text(dataAllPrest[index]['commune_prest'])),
      DataCell(Text(dataAllPrest[index]['ethnie_prest'])),
      DataCell(Text(dataAllPrest[index]['religion_prest'])),
      DataCell((dataAllPrest[index]['Statut'] != '0')
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : const Icon(
              Icons.close,
              color: Colors.red,
            )),
      DataCell(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed:edit,
                child: Text('Modifier'),
                style: ElevatedButton.styleFrom(primary: Colors.blue[400]),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: delete,
                child: Text('Delete'),
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
                                            "Id",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Nom & Prénom",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Contact",
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
                                            "Nationalité",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            " Commune",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Ethnie",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Réligions",
                                            style: TextStyle(
                                                color: Appcolor.bgColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Statut",
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
