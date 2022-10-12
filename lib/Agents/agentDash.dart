import 'package:easy_dashboard/easy_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:qal_web_admin/Agents/statst.dart';

import 'ajoutPrest.dart';


class AgtDashboard extends StatelessWidget {
  AgtDashboard({Key? key}) : super(key: key);
  late final EasyAppController controller = EasyAppController(
    intialBody: EasyBody(child:StatAgt(),title:Text('Ajouter un prestataires',style: TextStyle(fontSize:22,))),
  );
    List<SideTile>? title=[
      SideBarTile(icon:Icons.stacked_bar_chart_sharp, name:'Mes Statistiques', title:Text('Mes données',style: TextStyle(fontSize:22,)), body: StatAgt()),
      SideBarTile(icon:Icons.manage_history, name:'Gérer', title:Text('Ajouter un prestataires',style: TextStyle(fontSize:22)), body: agentAdd()),
      SideBarTile(icon:Icons.checklist_outlined, name:'Rapport', title:Text('Ajouter un prestataires',style: TextStyle(fontSize:22)), body:agentAdd() ),
      SideBarTile(icon:Icons.login, name:'Deconnexion', title:Text('',style: TextStyle(fontSize:22)), body: Text('body')),
    ];
  @override
  Widget build(BuildContext context) {
    return EasyDashboard(
      controller: controller,
      navigationIcon: const Icon(Icons.menu, color: Colors.white),
   //   appBarActions: actions,
      centerTitle: true,
      appBarColor: Colors.grey,
      sideBarColor: Colors.grey.shade100,
      tabletView: const TabletView(
        fullAppBar: true,
        border: BorderSide(width: 0.5, color: Colors.grey),
      ),
      desktopView: const DesktopView(
        fullAppBar: true,
        border: BorderSide(width: 0.5, color: Colors.grey),
      ),
      drawer: (Size size, Widget? child) {
        return EasyDrawer(
          iconColor: Colors.grey,
          hoverColor: Colors.grey.shade300,
          tileColor: Colors.grey.shade100,
          selectedColor: Colors.black.withGreen(80),
          selectedIconColor: Colors.white,
          textColor: Colors.black.withGreen(20),
          selectedTileColor: Colors.grey.shade400.withOpacity(.8),
          tiles: title,
          size: size,
          onTileTapped: (body) {
            controller.switchBody(body);
          },
        );
      },
    );
  }
}