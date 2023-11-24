import 'package:flutter/material.dart';
 class LoginNotifier extends ChangeNotifier{

   bool _obsecureText=true;
   bool get obsecuretext=>_obsecureText;

   set obsecuretext(bool newState){
     _obsecureText=newState;
     notifyListeners();
   }




 }