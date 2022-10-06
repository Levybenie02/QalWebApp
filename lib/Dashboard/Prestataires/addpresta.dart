import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qal_web_admin/Consts/Const.dart';
import 'package:http/http.dart'as http;

import '../../Host.dart';

class addClient extends StatefulWidget {
  const addClient({Key? key}) : super(key: key);
  static const String id = 'addClient_screen';
  @override
  State<addClient> createState() => _addClientState();
}

class _addClientState extends State<addClient> {
  List<dynamic> genre = [];
  List<dynamic> commune = [];
  String? genreId;
  dynamic communeId;

//PICKED IMAGE ++++++++++++
  File? imgfile;
  String imgstring = "";
  Uint8List webimage = Uint8List(8);
  Future<void> pickImg() async {
    if (!kIsWeb) {
      final ImagePicker picked = ImagePicker();
      XFile? image = await picked.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          imgfile = selected;
        });
      } else {
        print('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker picked = ImagePicker();
      XFile? image = await picked.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webimage = f;
          imgfile = File('a');
        });
      } else {
        print('No image has been picked');
      }
    } else {
      print('Aucune Image');
    }
  }

  final com = ['Abobo', 'Adjamé', 'Cocody'];
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
  TextEditingController birthcontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController genderccontroller = TextEditingController();
  TextEditingController commcontroller = TextEditingController();
    insertdata(String name, String num, String email, String pass, String birth,
      String age, String genre, String commune, String img) async {
        try {
           const url = '${Host.hostlink}/Inscriptionclient.php';
    final response = await http.post(Uri.parse(url), body: {
      "name": name, //php==>dart
      "num": num, //php==>dart
      "email": email, //php==>dart
      "pass": pass, //php==>dart
      "birth": birth, //php==>dart
      "age": age, //php==>dart
      "genre": genre, //php==>dart
      "commune": commune, //php==>dart
      "profilimg": img
    });
    if (response.statusCode == 200) {
      var jsondecode=jsonDecode(response.body);
      var outnum=jsondecode[0];
      if(outnum==0){
        print("Succes");
      }
      else
      {
        print("Error");
      }
    }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
  final addkey=GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // GENRE
    genre.add({'id': 1, 'label': 'Homme'});
    genre.add({'id': 2, 'label': 'Femme'});

    for (var i = 0; i < com.length; i++) {
      commune.add({'id': i + 1, 'label': com[i]});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Column(children: [
          SizedBox(height:10),
          const Text(
                                "Qal",
                                style: TextStyle(
                                    fontFamily: 'delicate',
                                    fontSize: 30,
                                    color: Appcolor.orangecolor),
                              ),
                                SizedBox(height:10),
          GestureDetector(
            onTap: () {
              pickImg();
            },
            child: CircleAvatar(
              backgroundColor: const Color.fromRGBO(228, 82, 6, 1),
              radius: 70,
              child: (imgfile == null)
                  ? CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 231, 227, 225),
                      radius: 68,
                      child: Image.asset(
                        "lib/Images/photo.png",
                        height: 60,
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: MemoryImage(webimage),
                      radius: 68,
                      child: null),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 420),
            child: Form(
              key:addkey,
              child: Column(
                children: [
                  formsfield(
                    textcontroller:namecontroller,
                    hint: 'Nom complet',
                    validator:((value) {
                      if(value=='' || value!.length<8 || value.contains('   ')){
                        return 'Veuillez saisir votre vrai prénom ';
                      }
                      return null;
                    })
                  ),
                  formsfield(
                                        textcontroller:numcontroller,
                    hint: 'Numéro de Téléphone',
                  ),
                  formsfield(
                    hint: 'Adresse Email',
                                        textcontroller:emailcontroller,

                  ),
                  formsfield(
                    hint: 'Mot de passe',
                                        textcontroller:passcontroller,

                  ),
                  formsfield(
                    hint: 'Confirmer le mot de passe',
                                        textcontroller:passcontroller,

                  ),
                  formsfield(
                    hint: 'Date de naissance',
                    textcontroller:birthcontroller,
                  ),
                  formsfield(
                    hint: 'Age',
                    textcontroller:agecontroller,
                  ),
                  const SizedBox(height:8,),
                  dropdownforms(
                    context,
                    'Genre',
                    genreId,
                    genre,
                      (onchangeval) {
                    genreId = onchangeval! ?? "";
                  }, (onvalide) {
                    if (onvalide == null) {
                      return 'Veuillez selectionner quelque chose';
                    } else {
                      return null;
                    }
                  },),
                  const SizedBox(height:14),
                  dropdownforms(
                    context,
                    'Commune',
                    communeId,
                    commune,
                      (onchangeval) {
                    communeId = onchangeval! ?? "";
                  }, (onvalide) {
                    if (onvalide == null) {
                      return 'Veuillez selectionner quelque chose';
                    } else {
                      return null;
                    }
                  },),
                   const SizedBox(height:10,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal:50,vertical:10),
             child: InkWell(
               onTap:(){
                                     insertdata(namecontroller.text, numcontroller.text, emailcontroller.text, passcontroller.text, birthcontroller.text, agecontroller.text, genreId!, communeId, webimage.toString());
               },
               child: Ink(
                                          height:45,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color:
                                                const Color.fromRGBO(228, 82, 6, 1),
                                          ),
                                          child: const Center(
                                            child: Text(
                                                    "INSCRIRE",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                          ),
                                        ),
             ),
           ),
                ],
              ),
            ),
          ),
        
       
        ]),
      ),
    );
  }
}
