// home_notifier.dart

import 'package:flutter/material.dart';

class Home_Notifier extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  set currentPage(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
