import 'package:flutter/material.dart';

class Device_Managment extends ChangeNotifier{
  int _currentpage=0;

  int get currentpage=>_currentpage;

  set currentpage(int index){
    _currentpage=index;
    notifyListeners();
  }


}