import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomTextCodabee extends Text {

  CustomTextCodabee(String data, {textAlign: TextAlign.center, color: Colors.indigo, fontSize: 15.0, fonStyle: FontStyle.italic }) : 
        super(
        data,
        textAlign: textAlign,
        style: new TextStyle(
            color: color,
            fontSize: fontSize,
            fontStyle: fonStyle
        ),
      );
}