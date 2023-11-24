
import 'package:flutter/cupertino.dart';

class SignUpNotifier extends ChangeNotifier {
  bool _obsecureText=true;
  bool get obsecuretext=>_obsecureText;

  set obsecuretext(bool newState){
    _obsecureText=newState;
    notifyListeners();
  }
}