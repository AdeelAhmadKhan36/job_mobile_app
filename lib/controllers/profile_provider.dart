import 'package:flutter/material.dart';

class Profile_Notifier extends ChangeNotifier{

  int _currentpage = 0;

  int get currentpage => _currentpage;

  set currenpage(int index) {
    _currentpage = index;
    notifyListeners();
  }
}