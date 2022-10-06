import 'package:flutter/material.dart';
import 'package:qal_web_admin/Consts/Const.dart';

class agentAdd extends StatefulWidget {
  const agentAdd({super.key});

  @override
  State<agentAdd> createState() => agentAddState();
}

class agentAddState extends State<agentAdd> {
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
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: formsfield(hint: 'Nom & prénom'),
                      ),
                      Expanded(
                        flex: 1,
                        child: formsfield(hint: 'Numéro de téléphone'),
                      ),
                      Expanded(
                        flex: 1,
                        child: formsfield(hint: 'Adresse email'),
                      ),
                    ],
                  ), Row(
                    children: [
                      Expanded(
                        flex:1,
                        child: formsfield(hint: 'Créer un mot de passe'),
                      ),
                      Expanded(
                        flex: 1,
                        child: formsfield(hint: 'Confirmer le mot de passe'),
                      ),
                      Expanded(
                        flex: 1,
                        child: formsfield(hint: 'Date de naissance'),
                      ),
                    ],
                  ),Row(
                    children: [
                      Expanded(
                        flex:1,
                        child: dropdownforms(context, 'Commune', 0, [], (){}, (){})
                      ),
                      Expanded(
                        flex: 1,
                        child: dropdownforms(context, 'Ethnie', 0, [], (){}, (){})
                      ),
                      Expanded(
                        flex: 1,
                        child: dropdownforms(context, 'Nationalité', 0, [], (){}, (){})
                      ),
                    ],
                  ),
                  SizedBox(height:10),
                  Row(
                    children: [
                      Expanded(
                        flex:1,
                        child: dropdownforms(context, 'Catégorie', 0, [], (){}, (){})
                      ),
                      Expanded(
                        flex: 2,
                        child: dropdownforms(context, 'Niveau d\'etude', 0, [], (){}, (){})
                      ),
                      Expanded(
                        flex: 1,
                        child: dropdownforms(context, 'Années \'experiences', 0, [], (){}, (){})
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
