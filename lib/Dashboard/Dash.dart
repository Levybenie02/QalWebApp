import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:qal_web_admin/Commande/valid.dart';
import 'package:qal_web_admin/Consts/Const.dart';
import 'package:qal_web_admin/Dashboard/Prestataires/addpresta.dart';

import '../Commande/Encours.dart';
import '../Commande/enattente.dart';
import 'Clients.dart';
import 'Dashboard1.dart';
import 'Prestataires/Allprestataires.dart';
import 'prestataires.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
    static const String id='home_screen';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

    Widget selectscreen= const DashboardScreen();
    currentScreen(item){  
      switch (item.route){
        case DashboardScreen.id:
        setState(() {
          selectscreen=const DashboardScreen();
        });
        break;
        case ClientScreen.id:
        setState(() {
          selectscreen=const ClientScreen();
        });
        break;

        case Allprestataire.id:
        setState(() {
          selectscreen=const Allprestataire();
        });
        break;

        case Cmdencours.id:
        setState(() {
          selectscreen=const Cmdencours();
        });
        break;

        case CmdAttente.id:
        setState(() {
          selectscreen=const CmdAttente();
        });
        break;

        case Cmdvalid.id:
        setState(() {
          selectscreen=const Cmdvalid();
        });
        break;

        case addClient.id:
        setState(() {
          selectscreen=const addClient();
        });
        break;
      }
    }
  @override
  Widget build(BuildContext context) {
    return AdminScaffold( 
      backgroundColor: Appcolor.greycolor,
        appBar:AppBar(
          iconTheme:const IconThemeData(color: Color.fromARGB(255, 28, 49, 77),),
          backgroundColor:Colors.white,
          title:const Text("Qal Dashboard",style:TextStyle(fontWeight:FontWeight.w700,color: Color.fromARGB(255, 28, 49, 66),),),
        ),
      sideBar: SideBar(
        backgroundColor: Colors.white,
        textStyle:const TextStyle(fontWeight:FontWeight.w600,color:Color.fromARGB(255, 28, 49, 66),),
        borderColor:Colors.white,
        
        items: const [
          AdminMenuItem(
            title: 'Tableau de bord',
            route:  DashboardScreen.id,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Qal Managment',
            icon: Icons.manage_accounts,
            children: [
            
              AdminMenuItem(
                title: 'Clients',
                 icon: Icons.people_rounded,
                children: [
                  AdminMenuItem(
                    title: 'Gérer client',
                    icon:Icons.manage_accounts_outlined,
                    route: ClientScreen.id,
                  ),
                   AdminMenuItem(
                    title: 'Ajouter un client',
                    icon:Icons.add_home_work,
                    route:addClient.id
                  ),
                ],
              ),
              AdminMenuItem(
                title: 'Prestataires',
                 icon: Icons.work_rounded,
                children: [
                  AdminMenuItem(
                    title: 'Prestataires',
                    icon:Icons.workspaces_sharp,
                    route:PrestScreen.id
                  ),
                 
                ],
              ),
              
              AdminMenuItem(
                title: 'Prestations',
                 icon: Icons.workspace_premium_outlined,
                children: [
                  AdminMenuItem(
                    title: 'Gerer une prestations',
                    icon:Icons.edit_attributes,
                    route: '/thirdLevelItem1',
                  ),
                ],
              ),
              AdminMenuItem(
                title: 'Commandes',
                icon:Icons.send,
                children: [
                  AdminMenuItem(
                    title: 'Commande en cours',
                     icon: Icons.watch_later_outlined,
                    route: Cmdencours.id,
                  ),
                  AdminMenuItem(
                    title: 'Commande validée',
                     icon: Icons.check,
                    route: Cmdvalid.id,
                  ),
                ],
              ),
            ],
          ),
          AdminMenuItem(
            title: 'Deconnexion',
            route: '/',
            icon: Icons.output_rounded,
          ),
        ],
        selectedRoute: Dashboard.id,
        onSelected: (item) {
          currentScreen(item);
        },
       
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Qal',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: selectscreen,
    );
  }
}