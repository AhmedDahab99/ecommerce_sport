import 'package:ecommerce_sport/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color colorBtn;
  final Color highlightColorBtn;
  final Color textBtnColor;
  final RoundedRectangleBorder roundedRectangleBorder;
  final Function onPressed;
  final EdgeInsets paddingBtn;
  final EdgeInsets circularPadding;
  final bool isLoading;
  final bool isDarkBtn;
  const CustomButton(
      {this.text,
      this.colorBtn,
      this.highlightColorBtn,
      this.onPressed,
      this.roundedRectangleBorder,
      this.paddingBtn,
      this.textBtnColor,
      this.isDarkBtn,
      this.circularPadding,
      this.isLoading});
  @override
  Widget build(BuildContext context) {
    final bool _isDarkBtn = isDarkBtn ?? false;
    final bool _isLoading = isLoading ?? false;

    return RaisedButton(
      elevation: 5.0,
      onPressed: onPressed,
      textColor: textBtnColor,
      shape: roundedRectangleBorder,
      color: _isDarkBtn ? colorBtn : colorBtn,
      highlightColor: highlightColorBtn,
      padding: paddingBtn,
      child: Stack(
        children: [
          Visibility(
            visible: _isLoading ? false : true,
              child: Text(
            text ?? "Nothing to Do",
            style: _isDarkBtn ? Constants.textDarkBtn : Constants.textLightBtn,
          )),
          Padding(
            padding: circularPadding,
            child: Visibility(
              visible: _isLoading,
              child: SizedBox(
                  height: 30.0, width: 30.0, child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
