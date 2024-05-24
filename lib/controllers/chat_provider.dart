import 'package:flutter/material.dart';

class userApp_Notifier extends ChangeNotifier{
  int _currentpage=0;

  int get currentpage=>_currentpage;

  set currentpage(int index){
    _currentpage = index;
    notifyListeners();
  }


}