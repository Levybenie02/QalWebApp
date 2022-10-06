// ignore_for_file: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../Host.dart';

class Appcolor {
  static const Color orangecolor = Color.fromRGBO(228, 82, 6, 1);
  static const Color whitecolor = Color.fromARGB(255, 239, 234, 234);
  static const Color blackcolor = Color.fromARGB(255, 36, 34, 33);
  static const Color greycolor = Color.fromRGBO(226, 226, 226, 1);
  static const Color primaryColor = Color(0xFF2697FF);
  static const Color secondarycolor = Color(0xFF2A2D3E);
  static const Color bgColor = Color(0xFF212332);
}

Widget formsfield({String? hint, TextEditingController? textcontroller,String? Function(String?)? validator}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
        controller: textcontroller,
        style: const TextStyle(color: Colors.black,fontSize:18),
        decoration: InputDecoration(
          label: Text(hint!),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          hintStyle: const TextStyle(color: Colors.black54),
          hintText: hint,
        ),
        validator:validator,
        ),
  );
}

Widget dropdownforms(BuildContext context, String hintText, dynamic value,
    List<dynamic> lstData, Function onChanged, Function onValidate) {
  return FormHelper.dropDownWidget(
      context, hintText, value, lstData, onChanged, onValidate,
      optionValue: 'id',
      optionLabel: 'label',
      textColor:Colors.black,
      hintFontSize:18,
      paddingLeft: 10,
      paddingRight: 10,
      borderRadius: 30,
      borderFocusColor: Colors.blue,
      borderColor: Color.fromARGB(255, 114, 114, 114),
      contentPadding: 19);
}

List datax = [];
