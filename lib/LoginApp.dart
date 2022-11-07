import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:qal_web_admin/Dashboard/Dash.dart';
import 'package:qal_web_admin/Host.dart';

import 'Agents/session.dart';
class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final emailtxt = TextEditingController();
  final passtxt = TextEditingController();
  String outnum = '';
  List output = [];
  bool login=false;
   List? datax;
   isConnected() async {
    await UserSessionData.getuser();
    if (UserSessionData.sessionUser != null) {
      setState(() {
        login = true;
       
      });
    } else {
      login = false;
    }
  }

  islogin() {
    login = !login;
  }
     Future loginScript(String email, String pass) async {
    try {
      var url = "${Host.hostlink}/AgentLogin.php";
      final response = await http.post(Uri.parse(url),body:{
      'email': email,
      'pass': pass,
      });
      if (response.statusCode == 200) {
        setState(() {
          datax = jsonDecode(response.body);
          if(datax![1]==0){
            Navigator.of(context).pop();
             setState(() {
          UserSessionData.savesession(UserSessionData.fromJson(datax![2]));
          UserSessionData.getuser();
          islogin();
        });
          }else
          {
            Navigator.pop(context);

          }
        });
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isConnected();
 //   getSession();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return (login)? Dashboard(): Scaffold(
        body: Center(
            child: Container(
                height: height * 0.45,
                width: width * 0.22,
                color: Colors.white10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Center(
                        child:
                            Text('Connexion', style: TextStyle(fontSize: 22))),
                    /* SizedBox(
                      height: 4,
                    ), */
                    Column(
                      children: [
                        formAdd(hint:'Email ou pseudo', icon:Icons.person, enable:true,controller: emailtxt ),
                        formAdd(hint:'Mot de passe', icon:Icons.password, enable:true, pass:true,controller:passtxt),
                        Padding(
                          padding: EdgeInsets.only(left: height * 0.2),
                          child: TextButton(
                              onPressed: () {},
                              child: const Text('Mot de passe oublié ?')),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(onPressed: (){
                          loginScript(emailtxt.text,passtxt.text);
                            showDialog(context: context,
                             builder: ((context) {
                               return Center(child: const CircularProgressIndicator());
                             })
                             );
                        }, child: Text("Connexion")),
                       // SizedBox(height:10),
                       (datax!=null)? Text(datax![0],style:TextStyle(color:Colors.red)):Text(''),
                      ],
                    ),
                    TextButton(onPressed:(){}, child: Text('Créer un compte')),
                  ],
                ))));
  }

  Widget loginform(String hint, TextEditingController? textcontroller,
      String Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textcontroller,
        style: const TextStyle(color: Colors.white54, fontSize: 18),
        decoration: InputDecoration(
          label: Text(hint),
          labelStyle: const TextStyle(color: Colors.white70),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          hintStyle: const TextStyle(color: Colors.white30),
          hintText: hint,
        ),
        validator: validator,
      ),
    );
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
        color: Color.fromARGB(40, 230, 230, 230),
        height: 35,
        width: 300,
        child: TextFormField(
          obscureText: pass,
          controller: controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabled: enable,
            prefixIcon: Icon(icon),
            hintText: hint,
          ),
        ),
      ),
    );
  }
}
