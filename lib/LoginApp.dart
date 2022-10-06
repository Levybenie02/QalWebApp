import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:qal_web_admin/Dashboard/Dash.dart';
import 'package:qal_web_admin/Host.dart';
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

   List datax = [];
    Future getSession() async {
    try {
      var url = "${Host.hostlink}/AgentLogin.php";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200){ 
        setState(() {
          datax = jsonDecode(response.body);
          if(datax[3]!=null){
            print(datax[0]);
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder:((context) => Dashboard())));
          }else
          {
            print('Identification echoué ☻');
          }
        });
      }
    } catch (e) {
      debugPrint("Execption Catch:$e");
    }
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
          if(datax[1]==0){
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder:((context) => Dashboard())));
          }else
          {
            print('Identification echoué ☻');
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
    getSession();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
            child: Container(
                height: height * 0.55,
                width: width * 0.23,
                color: Colors.white10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Center(
                        child:
                            Text('Connexion', style: TextStyle(fontSize: 22))),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        loginform('Adresse Email', emailtxt, null),
                        loginform('Mot de passe', passtxt, null),
                        Padding(
                          padding: EdgeInsets.only(left: height * 0.2),
                          child: TextButton(
                              onPressed: () {},
                              child: const Text('Mot de passe oublié ?')),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MaterialButton(
                          height: 55,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.blue,
                          onPressed: () {
                            loginScript(emailtxt.text,passtxt.text);
                            showDialog(context: context,
                             builder: ((context) {
                               return Center(child: const CircularProgressIndicator());
                             })
                             );
                          },
                          child: Text(
                            "CONNEXION",
                            style: GoogleFonts.itim(
                                fontSize: 23, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MaterialButton(
                        height: 55,
                        minWidth: height * 0.1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.green,
                        onPressed: () {},
                        child: Text(
                          "Créer un compte",
                          style: GoogleFonts.itim(
                              fontSize: 23, color: Colors.white),
                        ),
                      ),
                    ),
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
}
