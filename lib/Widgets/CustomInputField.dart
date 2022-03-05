import 'package:ecommerce_sport/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final TextStyle hintStyle;
  final Icon prefixIcon;
  final bool obscureText;
  final TextInputType textInputType;
//  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final Function(String) onSubmit;
  final FocusNode focusNode;
  final TextInputAction textInputAction;

  const CustomInputField(
      {this.hintText,
      this.prefixIcon,
      this.hintStyle,
//      this.textEditingController,
      this.obscureText,
      this.textInputType,
      this.onChanged,
      this.onSubmit,
      this.focusNode, this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Material(
        elevation: 3,
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(20.0),
        child: TextField(
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: onSubmit,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          autocorrect: true,
          cursorRadius: Radius.circular(20.0),
          obscureText: obscureText,
//          controller: textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            hintText: hintText,
            prefixIcon: prefixIcon,
          ),
          style: Constants.regularDarkText,
        ),
      ),
    );
  }
}
