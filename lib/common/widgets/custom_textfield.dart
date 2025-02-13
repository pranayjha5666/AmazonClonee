import 'package:flutter/material.dart';

class CustomtextFormField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomtextFormField({super.key, required this.controller, required this.hintText,  this.maxLines=1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val){
        if(val==null || val.isEmpty){
          return 'Enter your $hintText';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38)
        ),
        enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
        ),
      ),
      maxLines: maxLines,

    );
  }
}



