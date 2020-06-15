import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateConvertisseur {

  int differenceInHours = 0;
  int differenceInMinutes = 0;
  int differenceInDays = 0;

  calculerDiffDate(valDate) {
    var string = valDate;
    // Conversion de la string date. Format actuelle est:
    DateFormat format = new DateFormat("EEE, dd MMM yyyy hh:mm:ss zzz");
    //print(format.parse(string));
    DateTime valDateParsed = format.parse(string);
    var difference = new DateTime.now().difference(valDateParsed);
    // print(difference.inMinutes);
    this.differenceInHours = difference.inHours;
    this.differenceInMinutes = difference.inMinutes;
    this.differenceInDays = difference.inDays;
    if (differenceInMinutes < 60){
      return "il y a ${this.differenceInMinutes} minutes";
    } else if(this.differenceInHours > 24) {
      return "il y a ${this.differenceInDays} jours";
    } else if(this.differenceInMinutes > 60) {
      return "il y a ${this.differenceInHours} heures";
    }
  }
}