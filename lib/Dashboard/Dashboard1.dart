// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qal_web_admin/Consts/Const.dart';
import 'package:qal_web_admin/Forms/addForm.dart';
import 'package:qal_web_admin/Host.dart';
import '../Stats/Stat_dash.dart';
import '../Stats/Statclass.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String id = 'dashbord_screen';
  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  List datax = [];
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
          datax = jsonDecode(response.body);
          debugPrint(datax.length.toString());
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




  Future rechercher({required String search}) async {
    print('Search');
    setState(() {
      datax = [];
    });
    try {
      var url = "${Host.hostlink}/Search.php";
      final response = await http.post(Uri.parse(url), body: {
        'searchtxt': search,
      });
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        setState(() {
          datax = jsondata;
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
      datax = [];
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
          datax = jsondata;
          if (datax.isNotEmpty) {
            print(datax[0]);
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
  String? nb;
  void getStat() async{
    final response=await http.get(Uri.parse('${Host.hostlink}/stat1.php'));
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      setState(() {
        nb=data;
      });

    }

  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getStat();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
           //   const Statistiques(),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color:Color.fromARGB(255, 36, 53, 62),
                      height:100,
                      child:ListTile(
                        title:Text('Nombre de client',style:TextStyle(fontSize:22)),
                        trailing: Text("0"
                        ,style:TextStyle(fontSize:22)),
                      )
                    ),
                  ),
                   SizedBox(width:5),
                  Expanded(
                    child: Container(
                      color:Color.fromARGB(255, 58, 52, 52),
                      height:100,
                      child:ListTile(
                        title:Text('Nombre de client',style:TextStyle(fontSize:22)),
                        trailing: Text("0",style:TextStyle(fontSize:22)),
                      )
                    ),
                  ),
                   SizedBox(width:5),
                  Expanded(
                    child: Container(
                      color: Color.fromARGB(217, 181, 178, 178),
                      height:100,
                      child:ListTile(
                        title:Text('Nombre de client',style:TextStyle(fontSize:22)),
                        trailing: Text("0",style:TextStyle(fontSize:22)),
                      )
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                       
                        height:70,
                        decoration:BoxDecoration(
                           color:Color.fromARGB(255, 240, 241, 241),
                          border: Border.all(color:Color.fromARGB(107, 0, 0, 0))
                        ),
                        child:ListTile(
                        title:Text('Commande en attente',style:TextStyle(fontSize:18,color:Colors.black)),
                        trailing: Text("0",style:TextStyle(fontSize:18,color:Colors.green)),
                      )
                      ),
                    ),
                     SizedBox(width:10),
                    Expanded(
                      child: Container(
                       
                        height:70,
                        decoration:BoxDecoration(
                           color:Color.fromARGB(255, 240, 241, 241),
                          border: Border.all(color:Color.fromARGB(107, 0, 0, 0))
                        ),
                        child:ListTile(
                        title:Text('Commande rejetée',style:TextStyle(fontSize:18,color:Colors.black)),
                        trailing: Text("0",style:TextStyle(fontSize:18,color:Colors.green)),
                      )
                      ),
                    ),
                    SizedBox(width:10),
                    Expanded(
                      child: Container(
                       
                        height:70,
                        decoration:BoxDecoration(
                           color:Color.fromARGB(255, 240, 241, 241),
                          border: Border.all(color:Color.fromARGB(107, 0, 0, 0))
                        ),
                        child:ListTile(
                        title:Text('Commande validée',style:TextStyle(fontSize:18,color:Colors.black)),
                        trailing: Text("0",style:TextStyle(fontSize:18,color:Colors.green)),
                      )
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
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
                    (datax.isNotEmpty)
                        ? Center(
                            child: (datax[0] != "Empty")
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                       // border: TableBorder.all(),
                                        dataTextStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        columnSpacing: 30,
                                        columns:colonnes(),
                                        rows: List.generate(
                                            datax.length,
                                            (index) =>
                                                prestfiledata(context,datax, index, () {
                                                  print("object");
                                                  showDialog(
                                                      context: context,
                                                      builder: ((context) {
                                                        return CupertinoAlertDialog(
                                                          title:
                                                              const Text("Accept ?"),
                                                          content: Text(
                                                              "Voulez vous supprimer ${datax[index]['nomcomplet_prest']} de la liste des prestataires ?"),
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
                                                                      delete(idprest: datax[index]['Mat_prest']);
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
                        value1:datax[index]['Mat_prest'],
                        value2:datax[index]['nomcomplet_prest'],
                        value3:datax[index]['contact_prest'],
                        value4:datax[index]['Lib_serv'],
                        value5:datax[index]['nationalite_prest'],
                        value6:datax[index]['commune_prest'],
                        value7:datax[index]['ethnie_prest'],
                        value8:datax[index]['religion_prest'],
                        value9:datax[index]['Statut'],
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
          color: Color.fromARGB(217, 181, 178, 178),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Form(
          key: recherche,
          child: TextField(
            controller: searchtxt,
            style: TextStyle(color:Colors.black),
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

DataRow prestfiledata(BuildContext context,List datax, int index, void Function()? delete,void Function()? edit) {
  return DataRow(
    color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return Theme.of(context).colorScheme.primary.withOpacity(0.08);
    }
    return null;  // Use the default value.
  }),
    cells: [
      DataCell(Text(datax[index]['Mat_prest'])),
      DataCell(Text(datax[index]['nomcomplet_prest'])),
      DataCell(Text(datax[index]['contact_prest'])),
      DataCell(Text(datax[index]['Lib_serv'])),
      DataCell(Text(datax[index]['nationalite_prest'])),
      DataCell(Text(datax[index]['commune_prest'])),
      DataCell(Text(datax[index]['ethnie_prest'])),
      DataCell(Text(datax[index]['religion_prest'])),
      DataCell((datax[index]['Statut'] != '0')
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
                style: ElevatedButton.styleFrom(backgroundColor: Appcolor.bgColor),
                child: Text('Modifier'),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: delete,
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(217, 255, 82, 82),),
                child: Text('Delete'),
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
