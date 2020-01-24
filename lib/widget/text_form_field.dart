import 'package:flutter/material.dart';

class TextFormFieldCustomize extends StatelessWidget {

  String label;
  String hintText;
  bool obsText;
  int length;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;

  TextFormFieldCustomize(this.label, this.hintText, {this.obsText = false, this.length, this.controller, this.validator, this.keyboardType, this.textInputAction, this.focusNode, this.nextFocus});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: length,
      obscureText: obsText,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text){
        if(nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 20,
        ),
        hintText: hintText,
      ),
    );
  }
}
